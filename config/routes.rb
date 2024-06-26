
Rails.application.routes.draw do
  resources :agents do
    get :auto_complete_search, on: :collection
  end
end

Foreman::Application.routes.draw do
  mount ForemanAgentMonitoring::Engine, at: '/foreman_agent_monitoring'
end
