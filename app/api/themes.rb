# frozen_string_literal: true

require 'securerandom'

include Response

class Themes < Grape::API
  resource :themes do
    desc 'test'
    params do
      optional :id, type: Integer, desc: 'テーマのID'
    end
    get '/test', jbuilder: 'themes' do
      theme = Theme.where(id: params[:id])
      @themes = theme
    end

    desc 'テーマ情報取得'
    params do
      optional :id, type: Integer, desc: 'テーマのID'
      optional :area, type: String, desc: '地域名'
      optional :owner_id, type: String, desc: 'ownerユーザのID'
      optional :public, type: Boolean, desc: 'publicかどうか'
      optional :facing, type: Boolean, desc: '顔を出すかどうか'
    end
    get '/', jbuilder: 'themes' do
      themes = Theme.all
      themes = Theme.where(id: params[:id]) if params[:id]
      themes = Theme.by_area(params[:area]) if params[:area]
      themes = Theme.where(params[:owner_id]) if params[:owner_id]
      themes = Theme.where(params[:public]) if params[:public]
      themes = Theme.where(params[:facing]) if params[:facing]
      @themes = themes.
        with_detail(Area::LANG[params[:area]]).
        includes(
          :owner,
          {
            smiles: [
              :user,
              :othersmiles,
              :exercise,
              :comments
            ]
          },
          {
            joining_users: [
              smiles: [
                :user,
                :othersmiles,
                :exercise,
                :comments,
              ]
            ],
          },
          {
            invited_users: [
              smiles: [
                :user,
                :othersmiles,
                :exercise,
                :comments,
              ]
            ],
          }
        )
      @area = params[:area]
    end

    desc 'テーマ新規作成'
    params do
      requires :title, type: String, desc: 'タイトル'
      requires :owner_id, type: String, desc: 'ownerユーザのID'
      requires :message, type: String, desc: 'メッセージ'
      optional :image_file, desc: 'テーマ画像'
      optional :is_default, type: Boolean, desc: "デフォルトかどうか"
      optional :area, type: String, desc: 'エリア'
      #       optional :user_ids, type: String, desc: '招待したユーザID'
      requires :public, type: Boolean, desc: 'publicかどうか'
      requires :facing, type: Boolean, desc: '顔を出すかどうか'
    end
    post '/', jbuilder: 'themes' do
      user = User.find(params[:owner_id])

      @theme = Theme.create!(
        title: params[:title],
        area: params[:area] || user.area,
        message: params[:message],
        owner_id: params[:owner_id],
        public: params[:public],
        facing: params[:facing],
        is_default: params[:is_default] || false,
      )
      # @theme.update(image: decode_base64(params[:image_file], 'theme'))

      # TODO: boronngo@gmail.com トランザクション貼って保存に失敗した場合はロールバックする
      JoiningUserTheme.create!(
        user_id: params[:owner_id],
        theme_id: @theme.id
      )
    end

    desc '共通テーマ新規作成'
    params do
      requires :owner_id, type: String, desc: 'ownerユーザのID'
      requires :title_ja, type: String, desc: '日本語タイトル'
      requires :message_ja, type: String, desc: '日本語メッセージ'
      requires :title_en, type: String, desc: '英語タイトル'
      requires :message_en, type: String, desc: 'EUメッセージ'

      optional :image_file, desc: 'テーマ画像'
      optional :is_default, type: Boolean, desc: "デフォルトかどうか"
      requires :public, type: Boolean, desc: 'publicかどうか'
      requires :facing, type: Boolean, desc: '顔を出すかどうか'
    end
    post '/global', jbuilder: 'themes' do
      @theme = Theme.create!(
        title: params[:title_ja],
        area: Area::GLOBAL,
        message: params[:message_ja],
        owner_id: params[:owner_id],
        public: params[:public],
        facing: params[:facing],
        is_default: params[:is_default] || false,
      )
      # @theme.update(image: decode_base64(params[:image_file], 'theme'))

      @theme.theme_details.create!(
        lang: ThemeDetail.langs[:ja],
        title: params[:title_ja],
        message: params[:message_ja],
      )
      @theme.theme_details.create!(
        lang: ThemeDetail.langs[:en],
        title: params[:title_en],
        message: params[:message_en],
      )

      # TODO: boronngo@gmail.com トランザクション貼って保存に失敗した場合はロールバックする
      JoiningUserTheme.create!(
        user_id: params[:owner_id],
        theme_id: @theme.id
      )
    end

    route_param :id do
      desc 'テーマの設定を変更'
      params do
        requires :id, type: Integer, desc: 'テーマID'
        optional :title, type: String, desc: 'タイトル'
        optional :area, type: String, desc: '地域名'
        optional :message, type: String, desc: 'メッセージ'
        optional :image_file, desc: 'テーマ画像'
        optional :public, type: Boolean, desc: 'publicかどうか'
        optional :facing, type: Boolean, desc: '顔を出すかどうか'
      end
      post '/', jbuilder: 'themes' do
        theme = Theme.find(params[:id])


        update_params = {
          title: params[:title] || theme.title,
          area: params[:area] || theme.area,
          message: params[:message] || theme.message,
          image: decode_base64(params[:image_file], 'theme') || theme.image,
          public: params[:public] || theme.public,
          facing: params[:facing] || theme.facing
        }

        @theme = theme.update!(update_params)
      end

      desc 'テーマに参加する'
      params do
        requires :id, type: Integer, desc: 'テーマID'
        requires :user_id, type: Integer, desc: 'ユーザID'
      end
      post :join, jbuilder: 'api' do
        JoiningUserTheme.create!(
          user_id: params[:user_id],
          theme_id: params[:id]
        )

        invited_user_theme = InvitedUserTheme.find_by!(theme_id: params[:id], user_id: params[:user_id])
        invited_user_theme.update!(joined: true)

        invitation = Invitation.find_by!(theme_id: params[:id], invited_id: params[:user_id])
        invitation.update!(joined: true)
      end

      desc '招待コードを作成'
      params do
        requires :id, type: Integer, desc: 'テーマID'
        requires :inviter_id, type: Integer, desc: '招待を送るユーザID'
        optional :invited_ids, type: String, desc: '招待されるユーザID'
        requires :to_all, type: Boolean, desc: '全員に招待を送るか'
      end
      post :invite do
        if params[:to_all]
          user_all = User.all
          invitation_code = SecureRandom.hex(6)
          user_all.each do |user|
            Invitation.create!(
              theme_id: params['id'],
              inviter_id: params['inviter_id'],
              invited_id: user.id,
              code: invitation_code,
              joined: false,
              to_all: true
            )

            InvitedUserTheme.create!(
              user_id: user.id,
              theme_id: params['id'],
              joined: false
            )
          end
        else
          invited_ids = params[:invited_ids].split(',')
          invitation_code = nil
          invited_ids.each do |invited_id|
            Invitation.create!(
              theme_id: params['id'],
              inviter_id: params['inviter_id'],
              invited_id: invited_id.to_i,
              joined: false,
              to_all: false
            )

            InvitedUserTheme.create!(
              user_id: invited_id.to_i,
              theme_id: params['id'],
              joined: false
            )
          end
        end

        {
          result: true,
          data: {
            invitation_code: invitation_code
          }
        }
      end

      desc 'invited_usersを取得'
      params do
        requires :id, type: Integer, desc: 'テーマID'
      end
      get :invited_users do
        invited_users = Theme.find_by(id: params[:id]).invited_users
        hash = {}
        hash[:result] = true
        hash[:data] = {}
        hash[:data][:invited_users] = invited_users
        hash
      end

      desc 'joining_usersを取得'
      params do
        requires :id, type: Integer, desc: 'テーマID'
      end
      get :joining_users do
        joining_users = Theme.find_by(id: params[:id]).joining_users
        hash = {}
        hash[:result] = true
        hash[:data] = {}
        hash[:data][:joining_users] = joining_users
        hash
      end

      desc 'ownerを取得'
      params do
        requires :id, type: Integer, desc: 'テーマID'
      end
      get :owner do
        owner = Theme.find_by(id: params[:id]).owner
        hash = {}
        hash[:result] = true
        hash[:data] = {}
        hash[:data][:owner] = owner
        hash
      end

      desc 'themeに紐づけられてるsmilesを取得'
      params do
        requires :id, type: Integer, desc: 'テーマID'
        optional :user_id, type: Integer, desc: 'user_id'
      end
      get :smiles, jbuilder: 'smiles' do
        user = User.find(params[:user_id])
        @smiles = Theme.find_by(id: params[:id]).
          smiles.where.not(user_id: user.block_users.pluck(:id))

      end

    end
  end
end
