# frozen_string_literal: true

require 'digest'
require 'base64'

include Response
include Helpers


class Users < Grape::API
  resource :users do
   # before { admin_or_user_authenticate! }

    desc 'ログインしているユーザーを取得'
    get '/me', jbuilder: 'users' do
      @user = current_user
    end

    desc 'ユーザ情報取得'
    params do
      optional :id, type: Integer, desc: 'user_id'
      optional :fbid, type: String, desc: 'facebook id'
      optional :email, type: String, desc: 'メールアドレス'
      optional :name, type: String, desc: '名前'
    end
    get '/', jbuilder: 'users' do
      users = User.all
      users = users.where(id: params[:id]) if params[:id]
      users = users.where(fbid: params[:fbid]) if params[:fbid]
      users = users.where(email: params[:email]) if params[:email]
      users = users.where(name: params[:name]) if params[:name]
      @users = users
    end

    desc 'ユーザ登録する'
    params do
      requires :nickname, type: String, desc: '名前'
      requires :password, type: String, desc: 'パスワード'
      optional :name, type: String, desc: 'name'
      optional :gender, type: String, desc: '性別'
      optional :age, type: Integer, desc: '年齢'
      optional :job, type: String, desc: '仕事'
      optional :file, desc: 'プロフィール写真'
      optional :area, type: String, desc: '地域'
      optional :student_id, type: Integer
      optional :user_type, type: Integer
      optional :user_class, type: String
    end
    post '/', jbuilder: 'users' do
      JA_THEME_IDS = [7, 8, 9, 10, 11, 12]
      EN_THEME_IDS = [13, 14, 15]
      sha256 = Digest::SHA256.new
      user = User.new(
        nickname: params[:nickname],
        password: sha256.hexdigest(params[:password]),
	      name: params[:name],
        gender: params[:gender],
        age: params[:age],
        job: params[:job],
        area: params[:area] || "Asia",
        student_id: params[:student_id],
        user_type: params[:user_type],
        user_class: params[:user_class],
        )
      user.save
      # TODO: boronngo@gmail.com Active Storage�~A�管�~P~F�~A~Y�~B~K�~B~H�~A~F�~A��~A~W�~A~_�~A~D

      if params[:file]
        user.update(profile_path: decode_base64(params[:file], 'user'))
      end

      user.save!
      theme_ids = Theme.default_by_area(user.area).pluck(:id)
      theme_ids.each do |theme_id|
        JoiningUserTheme.create!(
          user_id: user.id,
          theme_id: theme_id
        )
      end

      @user = user
    end

    desc 'userを消す'
    params do
      requires :user_id, type: Integer, desc: 'user_id'
    end
    delete :delete, jbuilder: 'smiles' do
      User.find(params[:user_id]).destroy
    end

    desc 'fbtokenをアップデートする'
    params do
      requires :fbid, type: String, desc: 'facebookID'
      requires :fbtoken, type: String, desc: 'facebook token'
    end
    post :update, jbuilder: 'users' do
      user = User.find_by!(fbid: params[:fbid])
      @user = user.update!(fbtoken: params[:fbtoken])
    end

    resource :class do
      route_param :class_num do
        desc '同じクラスのユーザを取得'
        params do
          requires :class_num, type: Integer, desc: 'class番号'
        end
        get '/', jbuilder: 'users' do
          class_num = params[:class_num]
          @users = User.where('user_class like ?', "%,#{class_num},%")
        end
      end
    end

    route_param :user_id do

      desc 'update aware_id'
      params do
        requires :user_id, type: Integer, desc: 'ID'
        requires :aware_id, type: String, desc: 'aware_id'
      end
      post :upd_aware_id do
        aware_device = AwareDevice.new(
	        user_id: params[:user_id],
	        aware_id: params[:aware_id]
	      )
        aware_device.save
        hash = {}
        hash[:result] = true
        hash[:data] = {}
        hash[:data][:aware_device] = aware_device
        hash
      end

      desc 'profile_imageをアップデートする'
      params do
        requires :user_id, type: Integer, desc: 'ID'
        requires :file, desc: 'プロフィール写真'
      end
      post :upd_profile, jbuilder: 'users' do
        user = User.find_by(id: params[:user_id])
        user.update(profile_path: decode_base64(params[:file], 'user'))
        @user = user
      end

      desc '指定したuseridのにobjectionを加える'
      params do
        requires :user_id, type: Integer, desc: 'user_id'
      end
      post :object, jbuilder: 'users' do
        user = User.where(id: params[:user_id])
        user_object = user.objection
        user_object = 0 if user_object.nil?
        new_user_object = user_object + 1
        user[0].update_attributes(
          objection: new_user_object
        )
        @user = user[0]
      end

      desc 'ユーザが所属しているグループ情報'
      params do
        optional :user_id, type: Integer, desc: 'ユーザID'
      end
      get :groups do
        group_ids = []
        groups = []
        usergroups = UserGroup.where(user_id: params[:user_id])

        usergroups.each do |usergroup|
          group_id = usergroup.group_id
          group = Group.find_by(id: usergroup.group_id)
          group_attr = group.attributes
          usergroups_g = UserGroup.where(group_id: group_id)

          users = []
          user_ids = []
          usergroups_g.each do |usergroup_g|
            user = User.find_by(id: usergroup_g.user_id)
            users.push(user)
            user_ids.push(user.id)
          end
          group_attr[:users] = users

          smiles = []
          smilegroups = SmileGroup.where(group_id: group_id)
          smilegroups.each do |smilegroup|
            smile = Smile.find_by(id: smilegroup.smile_id)
            othersmiles_array = []
            othersmiles = smile.othersmiles.where(user_id: user_ids)
            othersmiles.each do |othersmile|
              user = User.find_by(id: othersmile.user_id)
              othersmile_attr = othersmile.attributes
              othersmile_attr[:user] = user.attributes
              othersmiles_array.push(othersmile_attr)
            end

            smile_attr = smile.attributes
            smile_attr[:othersmiles] = othersmiles_array
            smiles.push(smile_attr)
          end
          group_attr[:smiles] = smiles
          groups.push(group_attr)
        end

        hash = {}
        hash[:result] = true
        hash[:data] = {}
        hash[:data][:groups] = groups
        hash
      end

      desc 'ユーザが所属しているテーマを取得'
      params do
        requires :user_id, type: String, desc: 'ユーザID'
      end
      get :themes, jbuilder: 'themes' do
        joining_themes = Theme.joins(:joining_user_themes).where(joining_user_themes: {user_id: params['user_id']})
        joining_themes = joining_themes.includes([:owner, {invited_users: {smiles: [:user, :comments, :exercise]}}, {joining_users: {smiles: [:user, :comments, :exercise]}}, :smiles])
        @area = User.find(params['user_id']).area
        @themes = joining_themes
      end

      desc 'ユーザが所属しているテーマを取得_2'
      params do
        requires :user_id, type: String, desc: 'ユーザID'
      end
      get :themes_2, jbuilder: 'themes2' do
        theme_ids = Theme.
          joins(:joining_user_themes).
          where(joining_user_themes: {user_id: params['user_id']}).
          pluck(:id)
        @area = User.find(params['user_id']).area
        @themes = Theme.where(id: theme_ids).with_detail(Area::LANG[@area.to_sym])
        # hash = {}
        # hash[:result] = true
        # hash[:data] = {}
        # hash[:data][:themes] = joining_themes
        # hash
      end

      desc 'ユーザが招待されてるInvitationを取得'
      params do
        requires :user_id, type: String, desc: 'ユーザID'
      end
      get :invitations do
        invitations = Invitation.where(invited_id: params[:user_id], joined: false)
        hash = {}
        hash[:result] = true
        hash[:data] = {}
        hash[:data][:invitations] = [{}]
        if invitations
          array_invitation = []
          invitations.each do |invitation|
            hash_invitations = invitation.attributes
            hash_invitations[:invited_user] = User.where(id: invitation.invited_id)[0]
            hash_invitations[:inviter_user] = User.where(id: invitation.inviter_id)[0]
            theme = Theme.where(id: invitation.theme_id)[0]
            hash_invitations[:theme] = theme_response(theme)
            array_invitation.push(hash_invitations)
          end
          hash[:data][:invitations] = array_invitation
        end
        hash
      end

      desc 'ユーザが招待されてるInvitationを取得_2'
      params do
        requires :user_id, type: String, desc: 'ユーザID'
      end
      get :invitations_2 do
        invitations = Invitation.where(invited_id: params[:user_id], joined: false)
        hash = {}
        hash[:result] = true
        hash[:data] = {}
        hash[:data][:invitations] = [{}]
        if invitations
          array_invitation = []
          invitations.each do |invitation|
            hash_invitations = invitation.attributes
            hash_invitations[:invited_user] = invitation.invited
            hash_invitations[:inviter_user] = invitation.inviter
            hash_invitations[:theme] = invitation.theme
            array_invitation.push(hash_invitations)
          end
          hash[:data][:invitations] = array_invitation
        end
        hash
      end

      desc 'ユーザのポイント利用情報を取得'
      params do
        requires :user_id, type: Integer, desc: 'user_id'
      end
      get '/points' do
        point_uses = PointUse.where(user_id: params[:user_id])
        hash = {}
        hash[:result] = true
        hash[:data] = {}
        hash[:data][:point_uses] = point_uses
        hash
      end

      desc 'ユーザが投稿した笑顔情報を取得'
      params do
        requires :user_id, type: Integer, desc: 'user_id'
      end
      get '/smiles', jbuilder: 'smiles' do
        @smiles = Smile.where(user_id: params[:user_id])
      end

      resource :points do
        route_param :point_id do
          desc 'ポイント獲得・使用'
          params do
            requires :user_id, type: Integer, desc: 'user_id'
            requires :point_id, type: Integer, desc: 'point_id'
          end
          post '/' do
            user_all_point = UserAllPoint.find_by(user_id: params[:user_id])
            if user_all_point
              all_point = user_all_point.all_point

              today_point = user_all_point.today_point
              if user_all_point.updated_at < Time.zone.now.beginning_of_day
                user_all_point.update_attributes(
                  today_point: Point.find_by(id: params[:point_id]).point
                )
              else
                user_all_point.update_attributes(
                  today_point: today_point + Point.find_by(id: params[:point_id]).point
                )
              end

              user_all_point.update_attributes(
                  all_point: all_point + Point.find_by(id: params[:point_id]).point
              )

            else
              user_all_point = UserAllPoint.new(
                user_id: params[:user_id],
                all_point: Point.find_by(id: params[:point_id]).point,
                today_point: Point.find_by(id: params[:point_id]).point
              )
              user_all_point.save
            end

            point_use = PointUse.new(
                user_id: params[:user_id],
                point_id: params[:point_id]
            )
            point_use.save

            hash = {}
            hash[:result] = true
            hash[:data] = {}
            hash[:data][:point_use] = PointUse.find_by(id: point_use.id)
            hash
          end
        end

        desc 'ユーザのポイント利用情報を取得'
        params do
          requires :user_id, type: Integer, desc: 'user_id'
        end
        get :summary do
          point_info = UserAllPoint.find_by(user_id: params[:user_id])
          today_point = point_info.today_point
          all_point = point_info.all_point
          ranking_ids = UserAllPoint.all.order('all_point desc').select(:user_id).map(&:user_id)
          rank = ranking_ids.index(params[:user_id]) + 1
          rivals = User.joins(:user_all_points).where(user_all_points: {today_point: today_point-500..today_point+500}).select(:id, :nickname, :user_type, :user_class, :name, :email, :profile_path, :gender, :age, :job, :created_at, :updated_at, :all_point, :today_point)
          hash = {}
          hash[:result] = true
          hash[:data] = {}
          hash[:data][:point_summary] = {
            rank: rank,
            participants: UserAllPoint.count,
            today_points: today_point,
            all_points: all_point,
            rivals: rivals
          }
          hash
        end
      end

      resource :groups do
        route_param :group_id do
          desc 'ユーザが所属しているグループの笑顔一覧を取得'
          params do
            requires :user_id, type: Integer, desc: 'user_id'
            requires :group_id, type: Integer, desc: 'グループID'
          end
          get :smiles, jbuilder: 'api' do
            smile_ids = []
            smiles = []
            smilegroups = SmileGroup.where(group_id: params[:group_id])
            smilegroups.each do |smilegroup|
              smile_ids.push(smilegroup.smile_id)
            end
            smile_ids.each do |smile_id|
              smiles.push(Smile.where(id: smile_id, user_id: params[:user_id])).flatten!
            end
            @smiles = smiles.sort { |a, b| b['created_at'] <=> a['created_at'] }
          end

          desc 'グループからユーザを退会させる'
          params do
            requires :user_id, type: Integer, desc: 'user_id'
            requires :group_id, type: Integer, desc: 'グループID'
          end
          delete :leave, jbuilder: 'api' do
            usergroup = UserGroup.find_by(user_id: params[:user_id], group_id: params[:group_id])
            usergroup.destroy
          end
        end
      end
    end

    desc 'グループに追加する'
    params do
      optional :user_ids, type: String, desc: 'ユーザID'
      optional :group_id, type: Integer, desc: 'グループID'
    end
    post :add_group, jbuilder: 'api' do
      Rails.logger.debug(params[:user_ids])
      user_ids = params[:user_ids].split(',')
      usergroups = []
      user_ids.each do |user_id|
        if UserGroup.where(user_id: user_id, group_id: params[:group_id]).present?
          next
        end

        usergroup = UserGroup.new(
          user_id: user_id.to_i,
          group_id: params[:group_id]
        )
        usergroups.push(usergroup).flatten!
        usergroup.save
      end
      @usergroups = usergroups
    end
  end
end
