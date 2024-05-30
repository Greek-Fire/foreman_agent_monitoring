Rails.application.routes.draw do
  resources :agens do
    get :results, on: :collection
    get :auto_complete_search, on: :collection
  end
end