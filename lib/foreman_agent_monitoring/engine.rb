module ForemanAgentMonitoring
  class Engine < ::Rails::Engine
    engine_name 'foreman_agent_monitoring'

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/helpers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models"]
    config.autoload_paths += Dir["#{config.root}/lib"]
    config.autoload_paths += Dir["#{config.root}/app/overrides"]

    # Add any db migrations
    initializer 'foreman_agent_monitoring.load_app_instance_data' do |app|
      ForemanAgentMonitoring::Engine.paths['db/migrate'].existent.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    initializer 'foreman_agent_monitoring.register_plugin', :before => :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_agent_monitoring do
        requires_foreman '>= 3.7.0'
        register_gettext

        # Add Global files for extending foreman-core components and routes
        register_global_js_file 'global'

        # Add permissions
        security_block :foreman_agent_monitoring do
          permission :view_foreman_agent_monitoring, {:agents => %i[index auto_complete_search]}
        end

        # Add a new role called 'ForemanAgentMonitoring' if it doesn't exist
        role 'ForemanAgentMonitoring', [:view_foreman_agent_monitoring]

        # Add menu entry
        sub_menu :top_menu, :hallas_automation, caption: N_('Hallas Automation'), icon: 'pficon pficon-enterprise', after: :hosts_menu do
          menu :top_menu, :agents, caption: N_('Agents'), url_hash: { :controller => :agents, :action => :index }
        end

        # Add dashboard widget
        # widget 'foreman_agent_monitoring_widget', name: N_('Foreman plugin template widget'), sizex: 4, sizey: 1
      end
    end

    # Include concerns in this config.to_prepare block
    config.to_prepare do
      begin
        Host::Managed.send(:include, ForemanAgentMonitoring::HostExtensions)
        HostsHelper.send(:include, ForemanAgentMonitoring::HostsHelperExtensions)
      rescue => e
        Rails.logger.warn "ForemanAgentMonitoring: skipping engine hook (#{e})"
      end
    end

    rake_tasks do
      Rake::Task['db:seed'].enhance do
        ForemanAgentMonitoring::Engine.load_seed
      end
    end
  end
end
