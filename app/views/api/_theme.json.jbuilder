json.extract! theme, :id, :area, :image, :owner_id, :public, :facing, :created_at, :updated_at
json.message theme.native_message(area)
json.title theme.native_title(area)

json.owner_user do
  json.extract! theme.owner, :id, :nickname, :name, :user_type, :user_class, :profile_path, :gender, :age, :job, :created_at, :updated_at
end

json.invited_users do
  json.array!(theme.invited_users) do |invited_user|
    json.extract! invited_user, :id, :nickname, :name, :user_type, :user_class, :profile_path, :gender, :age, :job, :created_at, :updated_at
    json.smiles do
      json.array!(invited_user.smiles) do |smile|
        json.partial! 'smile', smile: smile
      end
    end

  end
end

json.joining_users do
  json.array!(theme.joining_users) do |joining_user|
    json.extract! joining_user, :id, :nickname, :name, :user_type, :user_class, :profile_path, :gender, :age, :job, :created_at, :updated_at
    json.smiles do
      json.array!(joining_user.smiles) do |smile|
        json.partial! 'smile', smile: smile
      end
    end
  end
end

# TODO: boronngo@gmail.com Smileとのリレーションを確認後に復活させる
json.smiles theme.smiles do |smile|
  json.partial! 'smile', smile: smile
end
