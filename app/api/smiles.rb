require 'open-uri'
require 'base64'

class Smiles < Grape::API
  resource :smiles do
    desc '最新または指定した笑顔データを取得'
    params do
      requires :user_id, type: Integer, desc: 'user_id'
      optional :date, type: Date, desc: '日付'
      optional :limit, type: Integer, desc: '取得する件数'
      optional :offset, type: Integer, desc: '最新のx番目から取得'
    end
    get '/', jbuilder: 'smiles' do
      smiles = Smile.all
      user = User.find(params[:user_id])
      smiles = smiles.where(user_id: user.id)

      if params[:date]
        smiles = smiles.gte(time: params[:date]).lt(time: params[:date].tomorrow)
      end
      if params[:limit]
        smiles = smiles.order(created_at: :desc).limit(params[:limit])
      end
      if params[:offset]
        smiles = smiles.offset(params[:offset])
      end

      @smiles = smiles
    end

    desc "笑顔を検索"
    params do
      optional :id, type: Integer, desc: 'smileid'
    end
    get :search, jbuilder: 'smiles' do
      @smile = Smile.where(id: params[:id])[0]
    end

    desc "笑顔データを送信する"
    params do
      requires :user_id, type: Integer, desc: 'user_id'
      optional :lat, type: Float, desc: "緯度"
      optional :lon, type: Float, desc: "経度"
      optional :file, desc: "笑顔の写真"
      optional :mode, desc: "mode"
      optional :group_ids, type: String, desc: "groupID"
      optional :theme_ids, type: String, desc: "themeID"
      optional :degree, type: Float, desc: "笑顔度"
      optional :caption, type: String, desc: "キャプションのtext"
      optional :exercise_time, type: Integer
      optional :barometer_max, type: Float
      optional :barometer_min, type: Float
      optional :barometer_average, type: Float
      optional :barometer_standard_deviation, type: Float
      optional :distance, type: Integer
      optional :speed_max, type: Float
      optional :speed_average, type: Float
      optional :speed_standard_deviation, type: Float
      optional :speed_dash_count, type: Integer
      optional :acc_x_max, type: Float
      optional :acc_x_min, type: Float
      optional :acc_x_average, type: Float
      optional :acc_x_standard_deviation, type: Float
      optional :acc_x_rotation_count, type: Float
      optional :acc_y_max, type: Float
      optional :acc_y_min, type: Float
      optional :acc_y_average, type: Float
      optional :acc_y_standard_deviation, type: Float
      optional :acc_y_rotation_count, type: Float
      optional :acc_z_max, type: Float
      optional :acc_z_min, type: Float
      optional :acc_z_average, type: Float
      optional :acc_z_standard_deviation, type: Float
      optional :acc_z_rotation_count, type: Float
      optional :balanced_time, type: Integer
      optional :power, type: Float
      optional :rpe, type: Integer
      optional :gyro_x_max, type: Float
      optional :gyro_x_min, type: Float
      optional :gyro_x_ave, type: Float
      optional :gyro_x_standard_deviation, type: Float
      optional :gyro_y_max, type: Float
      optional :gyro_y_min, type: Float
      optional :gyro_y_ave, type: Float
      optional :gyro_y_standard_deviation, type: Float
      optional :gyro_z_max, type: Float
      optional :gyro_z_min, type: Float
      optional :gyro_z_ave, type: Float
      optional :gyro_z_standard_deviation, type: Float
      optional :satisfaction, type: Integer
      optional :emotion, type: Integer
      optional :backfile, desc: "バック写真"
    end
    post '/', jbuilder: 'smiles' do
      smile = Smile.new(
        user_id: params[:user_id],
        lat: params[:lat],
        lon: params[:lon],
        mode: params[:mode],
        degree: params[:degree],
        caption: params[:caption]
        )
      smile.save
      if not params[:file].nil?
        smile.update(pic_path: decode_base64(params[:file], 'smile'))
      end

      if not params[:group_ids].nil?
        group_ids = params[:group_ids].split(',')
        smilegroups = []
        group_ids.each do |group_id|
          if !SmileGroup.where(smile_id: smile.id, group_id: group_id).present?
            smilegroup = SmileGroup.new(
      	      smile_id: smile.id,
      	      group_id: group_id.to_i,
      			)
            smilegroups.push(smilegroup).flatten!
      	    smilegroup.save
          end
        end
      end
      if not params[:theme_ids].nil?
        theme_ids = params[:theme_ids].split(',')
        smilethemes = []
        theme_ids.each do |theme_id|
          if !SmileTheme.where(smile_id: smile.id, theme_id: theme_id).present?
            smiletheme = SmileTheme.new(
              smile_id: smile.id,
              theme_id: theme_id.to_i,
            )
            smilethemes.push(smiletheme).flatten!
            smiletheme.save
          end
        end
      end
      if not params[:backfile].nil?
        smile.update(back_pic_path: decode_base64(params[:backfile], 'smile'))
      end
      exercise = Exercise.new(
          exercise_time: params[:exercise_time],
          barometer_max: params[:barometer_max],
          barometer_min: params[:barometer_min],
          barometer_average: params[:barometer_average],
          barometer_standard_deviation: params[:barometer_standard_deviation],
          distance: params[:distance],
          speed_max: params[:speed_max],
          speed_average: params[:speed_average],
          speed_standard_deviation: params[:speed_standard_deviation],
          speed_dash_count: params[:speed_dash_count],
          acc_x_max: params[:acc_x_max],
          acc_x_min: params[:acc_x_min],
          acc_x_average: params[:acc_x_average],
          acc_x_standard_deviation: params[:acc_x_standard_deviation],
          acc_x_rotation_count: params[:acc_x_rotation_count],
          acc_y_max: params[:acc_y_max],
          acc_y_min: params[:acc_y_min],
          acc_y_average: params[:acc_y_average],
          acc_y_standard_deviation: params[:acc_y_standard_deviation],
          acc_y_rotation_count: params[:acc_y_rotation_count],
          acc_z_max: params[:acc_z_max],
          acc_z_min: params[:acc_z_min],
          acc_z_average: params[:acc_z_average],
          acc_z_standard_deviation: params[:acc_z_standard_deviation],
          acc_z_rotation_count: params[:acc_z_rotation_count],
          balanced_time: params[:balanced_time],
          power: params[:power],
          rpe: params[:rpe],
          gyro_x_max: params[:gyro_x_max],
          gyro_x_min: params[:gyro_x_min],
          gyro_x_ave: params[:gyro_x_ave],
          gyro_x_standard_deviation: params[:gyro_x_standard_deviation],
          gyro_y_max: params[:gyro_y_max],
          gyro_y_min: params[:gyro_y_min],
          gyro_y_ave: params[:gyro_y_ave],
          gyro_y_standard_deviation: params[:gyro_y_standard_deviation],
          gyro_z_max: params[:gyro_z_max],
          gyro_z_min: params[:gyro_z_min],
          gyro_z_ave: params[:gyro_z_ave],
          gyro_z_standard_deviation: params[:gyro_z_standard_deviation],
          satisfaction: params[:satisfaction],
          emotion: params[:emotion],
          smile_id: smile.id
      )
      exercise.save
      smile.update(exercise_id: exercise.id)
      @smile = Smile.where(id: smile.id)[0]
    end

    route_param :id do
      desc "指定したidの笑顔データを取得"
      params do
        requires :id, type: Integer, desc: "id"
      end
      get jbuilder: 'smiles' do
        @smile = Smile.where(id: params[:id])[0]
      end

      desc "笑顔データを削除する"
      params do
        requires :id, type: Integer, desc: 'id'
      end
      delete :delete, jbuilder: 'smiles' do
        smile = Smile.find_by(id: params[:id])
        smile.destroy
      end

      desc "笑顔データを送信する(hybrid)"
      params do
        requires :id, type: Integer, desc: "smile_id"
        optional :backfile, desc: "バック写真"
      end
      post :hybrid, jbuilder: 'smiles' do
        @smile = Smile.find_by(id: params[:id])
        @smile.update(back_pic_path: decode_base64(params[:backfile], 'smile'))
      end

      desc "指定したidの笑顔に対して反応した笑顔データを送信する"
      params do
        requires :id, type: Integer, desc: "id"
        requires :user_id, type: Integer, desc: 'user_id'
        optional :lat, type: Float, desc: "緯度"
        optional :lon, type: Float, desc: "経度"
        # optional :file, desc: "笑顔の写真"
        optional :mode, desc: "mode"
        optional :degree, type: Float, desc: "笑顔度"
      end

      post :otherpost, jbuilder: 'smiles' do
        smile = Smile.find(params[:id])
        other_smile = Othersmile.create(
          smile_id: smile.id,
          user_id: params[:user_id],
          lat: params[:lat],
          lon: params[:lon],
          mode: params[:mode],
          degree: params[:degree]
        )

        @smile = Smile.find(params[:id])
      end

      desc "指定したidの笑顔に対して反応した笑顔度の差を送信する"
      params do
        requires :id, type: Integer, desc: "id"
        requires :user_id, type: Integer, desc: 'user_id'
        optional :lat, type: Float, desc: "緯度"
        optional :lon, type: Float, desc: "経度"
        optional :mode, desc: "mode"
        optional :first_degree, type: Float, desc: "最初の笑顔度"
        optional :max_degree, type: Float, desc: "MAX笑顔度"
      end
      post :diff_degree, jbuilder: 'smiles' do
        smile = Smile.where(id: params[:id])
        other_smile = Othersmile.new(
          user_id: params[:user_id],
          lat: params[:lat],
          lon: params[:lon],
          mode: params[:mode],
          first_degree: params[:first_degree],
          max_degree: params[:max_degree],
          diff_degree: params[:max_degree] - params[:first_degree]
        )
        smile[0].othersmiles.push(other_smile)
        @smile = smile[0]
      end

      desc "指定したgroupに笑顔を登録する"
      params do
        requires :id, type: Integer, desc: "smile_id"
        requires :group_id, type: Integer, desc: "グループid"
      end
      post :group, jbuilder: 'smiles' do
        smile = Smile.where(id: params[:id])
        smile_id = smile.id
        smilegroup = SmileGroup.new(
          smile_id: smile_id,
          group_id: params[:group_id]
        )
        smilegroup.save
      end

      desc  "指定したidに対して笑顔度を更新する"
      params do
        requires :id, type: Integer, desc: "smile_id"
        requires :degree, type: Float, desc: "smile_degree"
      end
      post :update_degree, jbuilder: 'smiles' do
        smile = Smile.find_by(id: params[:id])
        smile.update_attributes(
          degree:  params[:degree]
        )
        @smile = Smile.where(id: params[:id])[0]
      end

      desc "smileに付随するコメントを取得"
      params do
        requires :id, type: Integer, desc: "smile_id"
      end
      get :comments, jbuilder: 'smiles' do
        smile = Smile.where(id: params[:id])[0]
        @smile = smile
      end

      desc "投稿されたsmileに対してコメントを付与"
      params do
        requires :id, type: Integer, desc: "smile_id"
        requires :user_id, type: Integer, desc: "user_id"
        requires :text, type: String, desc: "comment text"
      end
      post :comments, jbuilder: 'smiles' do
        smile = Smile.where(id: params[:id])[0]
        comment = Comment.new(
          smile_id: smile.id,
          user_id: params[:user_id],
          text: params[:text]
        )
        comment.save
        @smile = smile
      end

      desc 'themeをレポートする'
      params do
        requires :id, type: Integer, desc: 'smile_id'
        requires :user_id, type: Integer, desc: 'user_id'
      end
      post :reports, jbuilder: 'themes' do
        @smile = Smile.find(params[:id])
        SmileReport.create!(
          smile_id: @smile.id,
          user_id: params[:user_id],
        )
      end
    end
  end
end
