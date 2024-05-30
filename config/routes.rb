
Rails.application.routes.draw do
  resources :agents do
    get :auto_complete_search, on: :collection
  
  namespace :api do
    namespace :v2 do
      resources :agents
    end
  end
end