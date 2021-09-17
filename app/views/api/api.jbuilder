json.result true
# json.message I18n.t('api.success_message.get')
json.data do
  if not @groups.nil?
    json.groups do
      json.array!(@groups) do |group|
        json.(group, :id, :group_name)
      end
    end
  end
  if not @smiles.nil?
    json.smiles do
      json.array!(@smiles) do |smile|
        json.(smile, :id, :user_id, :pic_path, :degree, :lat, :lon, :back_pic_path, :mode)
        json.othersmiles smile.othersmiles do |othersmile|
          json.(othersmile, :id, :smile_id, :user_id, :pic_path, :diff_degree, :max_degree, :first_degree, :lat, :lon, :mode)
        end
        json.comments smile.comments do |comment|
          json.(comment, :id, :smile_id, :user_id)
        end
      end
    end
  end
  if not @users.nil?
    json.users do
      json.array!(@users) do |user|
        json.(user, :id, :email, :name, :profile_path, :nickname, :password, :gender, :age, :job)
        json.smiles user.smiles do |smile|
          json.(smile, :id, :user_id, :pic_path, :degree, :lat, :lon, :back_pic_path, :mode)
        end
        json.locations user.locations do |location|
          json.(location, :id, :user_id, :lat, :lon)
        end
      end
    end
  end
  if not @usergroups.nil?
    json.usergroups do
      json.array!(@usergroups) do |usergroup|
        json.(usergroup, :id, :user_id, :group_id)
      end
    end
  end
  if not @smilegroups.nil?
    json.smilegroups do
      json.array!(@smilegroups) do |smilegroup|
        json.(smilegroup, :id, :smile_id, :group_id)
      end
    end
  end
  if not @smilethemes.nil?
    json.smilethemes do
      json.array!(@smilethemes) do |smiletheme|
        json.(smiletheme, :id, :smile_id, :theme_id)
      end
    end
  end
  if not @themes.nil?
    json.themes do
      json.array!(@themes) do |theme|
        json.(theme, :id, :area, :message, :image, :owner_id, :timestamp)
        json.smiles theme.smiles do |smile|
          json.(smile, :id, :user_id, :pic_path, :degree, :lat, :lon, :back_pic_path, :mode, :caption)
        end
      end
    end
  end
  if not @point_uses.nil?
    json.point_uses do
      json.array!(@point_uses) do |point_use|
        json.(point_use, :id, :point_id, :user_id)
      end
    end
  end
  if not @points.nil?
    json.points do
      json.array!(@points) do |point|
        json.(point, :id, :reason, :point)
      end
    end
  end
  if not @point_summaries.nil?
    json.point_summaries do
      json.array!(@point_summaries) do |point_summary|
        json.(point_summary, :id, :allPoints, :todayPoints, :rank, :user_id)
      end
    end
  end
  if not @invitations.nil?
    json.invitations do
      json.array!(@invitations) do |invitation|
        json.(invitation, :id, :code, :inviter_id, :theme_id, :invited_id, :joined, :to_all)
      end
    end
  end
end