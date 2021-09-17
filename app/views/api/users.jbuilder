json.result true
json.data do
  if not @users.nil?
    json.users do
      json.array!(@users) do |user|
        json.partial! 'user', user: user
      end
    end
  end

  if not @user.nil?
    json.user do
      json.partial! 'user', user: @user
    end
  end
end