Rails.application.routes.draw do
  resources :agents do
    get :auto_complete_search, on: :collection
  end
end