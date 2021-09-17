require 'active_model'

class API < Grape::API
  # version 'v1', using: :path

  format :json
  formatter :json, Grape::Formatter::Jbuilder
  prefix :api

  rescue_from JWT::VerificationError do |e|
    error!(e.message, 401)
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    error!(e.message, 400)
  end

  # 例外ハンドル 404
  rescue_from ActiveRecord::RecordNotFound do |e|
    error!(e.message, 404)
  end

  # 例外ハンドル 400
  rescue_from Grape::Exceptions::ValidationErrors do |e|
    error!(e.message, 400)
  end

  rescue_from ActiveRecord::RecordNotUnique do |e|
    error!(e.message, 422)
  end

  rescue_from ArgumentError do |e|
    error!(e.message, 400)
  end

  # 例外ハンドル 500
  rescue_from :all do |e|
    if Rails.env.development?
      raise e
    else
      error!({error: e.message, backtrace: e.backtrace[0]}, 500)
    end
  end

  before do
    error!('invalid seed', 500) if headers['Seed'] != GrapeSwaggerRails.options.headers['Seed']
  end

  mount API::Users
  mount API::Users::Login
  mount API::Users::Blocks
  mount API::Groups
  mount API::Smiles
  mount API::Logs
  mount API::Themes
  mount API::Invites
  mount API::Points

  add_swagger_documentation add_version: true

end
