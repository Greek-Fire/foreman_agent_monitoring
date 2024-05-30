ForemanAgentMonitoring::Engine.routes.draw do
  resources :agents do
    get :results, on: :collection
    get :auto_complete_search, on: :collection
  end

  root to: 'agents#index'
end

Foreman::Application.routes.draw do
  mount ForemanAgentMonitoring::Engine, at: '/foreman_agent_monitoring'
end