
ForemanAgentMonitoring::Engine.routes.draw do
  resources :agents do
    get :auto_complete_search, on: :collection
    get 'welcome', to: '/react#index', as: 'welcome'
  end
end

Foreman::Application.routes.draw do
  mount ForemanAgentMonitoring::Engine, at: '/Foreman_agent_monitoring'
end