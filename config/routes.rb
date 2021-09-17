Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'health' => lambda { |env| [200, { 'Content-Type' => 'text/plain' }, ['OK']] }
  mount API => '/'
  mount GrapeSwaggerRails::Engine => '/docs'

  get 'redirect/index'
  get 'redirect/index/:url' => 'redirect#index'
end
