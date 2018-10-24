# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, constraints: { subdomain: 'api' }, path: '/' do
    namespace :v1 do
      get :status, controller: 'homes'
      get '/:short_url', to: 'homes#show'
      post :create, controller: 'homes'
      post '/', controller: 'homes', action: :create
    end
  end
end
