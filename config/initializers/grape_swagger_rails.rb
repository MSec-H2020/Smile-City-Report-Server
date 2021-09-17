GrapeSwaggerRails.options.app_name = 'smilex'
GrapeSwaggerRails.options.app_url  = '/'
GrapeSwaggerRails.options.url = 'api/swagger_doc.json'
GrapeSwaggerRails.options.headers['Seed'] = ENV['GRAPE_SWAGGER_SEED']
GrapeSwaggerRails.options.headers['X-Admin-Token'] = ENV['ADMIN_TOKEN']
GrapeSwaggerRails.options.before_filter do |request|
  authenticate_or_request_with_http_basic do |user, pass|
    user == ENV['BASIC_AUTH_USER'] && pass == ENV['BASIC_AUTH_PASSWORD']
  end
end
