# frozen_string_literal: true

require 'digest'
include Response
include Helpers

class Users::Login < Grape::API
  resource :users do
    desc 'ログインする'
    params do
      requires :nickname, type: String, desc: 'ニックネーム'
      requires :password, type: String, desc: 'パスワード'
    end

    post '/login' do
      sha256 = Digest::SHA256.new
      user = User.authorize(params[:nickname], params[:password])
      if user
        token = JWTHeader.encode(user.id)
        header 'Authorize', token
        login_success = true
        user_hash = user.attributes
        user_hash.delete("password")
        user_hash.delete("student_id")
        user_hash.delete("profile_path")
        user_hash[:profile_path] = user.profile_path
      else
        login_success = false
      end

      hash = {}
      hash[:result] = true
      hash[:data] = {}
      hash[:data][:login_success] = login_success
      hash[:data][:user] = user_hash
      hash
    end
  end
end
