json.smile do
  json.extract! smile, :id, :user_id, :pic_path, :degree, :lat, :lon, :back_pic_path, :mode, :caption, :exercise_id, :created_at, :updated_at
end


json.comments do
  json.array!(smile.comments) do |comment|
    json.extract! comment, :id, :user_id, :smile_id, :text, :created_at, :updated_at
    json.user do
      json.extract! comment.user, :id, :name, :user_type, :user_class, :profile_path, :gender, :age, :job, :created_at, :updated_at
    end
  end
end

if not smile.exercise.nil?
  json.exercise do
    json.merge! smile.exercise.attributes
  end
end

json.othersmiles do
  json.array!(smile.othersmiles) do |othersmile|
    json.extract! othersmile, :id, :smile_id, :user_id, :lat, :lon, :first_degree, :max_degree, :created_at, :updated_at
  end
end

json.user do
  json.extract! smile.user, :id, :nickname, :user_type, :user_class, :name, :profile_path, :gender, :age, :job, :created_at, :updated_at
end
