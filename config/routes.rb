ForemanAgentMonitoring::Engine.routes.draw do
  get 'index', to: 'agent#index', as: 'index'
  get 'plugin_template_description', to: 'example#react_template_page_description'
  get 'welcome', to: '/react#index', as: 'welcome'
end

Foreman::Application.routes.draw do
  mount ForemanAgentMonitoring::Engine, at: '/foreman_agent_monitoring'
end
