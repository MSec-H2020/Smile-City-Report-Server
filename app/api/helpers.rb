module  Helpers
  def current_user
    user_id = JWTHeader.authorize(headers)
    return unless user_id
    User.find(user_id)
  end

  def authenticate!
    error!('401 Unauthorized', 401) unless current_user
  end

  def admin_or_user_authenticate!
    error!('401 Unauthorized', 401) unless current_user || admin_authenticate
  end

  def admin_authenticate
    headers['X-Admin-Token'] == GrapeSwaggerRails.options.headers['X-Admin-Token']
  end

  def decode_base64(str, img_type)
    # bin = Base64.decode64(str['data:image/jpeg;base64,'.length .. -1])
    bin =  Base64.decode64(str)
    file = Tempfile.new(img_type)
    file.binmode
    file << bin
    file.rewind
    return file
  end
end
