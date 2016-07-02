Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount API::V1::Main, at: "/v1/"
  mount API::V2::Main, at: "/v2/"
  mount GrapeSwaggerRails::Engine, at: "/documentation"
end
