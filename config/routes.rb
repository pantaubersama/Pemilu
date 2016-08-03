Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount API::Init, at: "/"
  mount GrapeSwaggerRails::Engine, as: "doc_v1", at: "/documentation/v1"
  mount GrapeSwaggerRails::Engine, as: "doc_v2", at: "/documentation/v2"
end
