json.extract! user, :id, :nickname, :user_type, :user_class,
                    :name, :email, :profile_path, :gender,
                    :age, :job, :created_at, :updated_at, :area

json.smiles do
  json.array!(user.smiles) do |smile|
    json.partial! 'smile', smile: smile
  end
end

json.locations do
  json.array!(user.locations) do |location|
    json.extract! location, :id, :user_id, :lat, :lon, :created_at, :updated_at
  end
end

