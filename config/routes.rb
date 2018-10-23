Rails.application.routes.draw do
  namespace :api, constraints: { subdomain: 'api' }, path: '/', defaults: { format: 'json' } do
    namespace :v1, defaults: { format: 'json' } do
      get :status, controller: 'homes'
    end
  end
end
