class JWTHeader
  class << self
    TOKEN_PREFIX = /^Bearer\s/
    TOKEN_REGEX = /^Bearer\s(.+)/

    def encode(uid)
      puts jwt_private_key

      payload = { iss: 'jn@sfc.keio.ac.jp',
                  iat: Time.now.to_i,
                  exp: 1.years.from_now.to_i,
                  uid: uid,
                  claims: { uid: uid } }
      JWT.encode payload, jwt_private_key, "HS256"
    end

    def authorize(headers)
      return unless headers['Authorization'] && headers['Authorization'].match(TOKEN_REGEX)
      token = headers['Authorization'].gsub(TOKEN_PREFIX, '')

      decoded_token = JWT.decode token, jwt_private_key, true, algorithm: "HS256"
      return unless decoded_token

      exp = decoded_token[0]["exp"]
      raise InvalidAuthenticityToken.new("Token is expired") if exp < Time.now.to_i

      decoded_token[0]["uid"]
    end

    private
    def jwt_private_key
      ENV['HMAC_SECRET']
    end
  end

end
