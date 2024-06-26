require 'rake/testtask'

# Tasks
namespace :foreman_agent_monitoring do
  namespace :example do
    desc 'Example Task'
    task task: :environment do
      # Task goes here
    end
  end
end

# Tests
namespace :test do
  desc 'Test ForemanAgentMonitoring'
  Rake::TestTask.new(:foreman_agent_monitoring) do |t|
    test_dir = File.expand_path('../../test', __dir__)
    t.libs << 'test'
    t.libs << test_dir
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
    t.warning = false
  end
end

namespace :foreman_agent_monitoring do
  task :rubocop do
    begin
      require 'rubocop/rake_task'
      RuboCop::RakeTask.new(:rubocop_foreman_agent_monitoring) do |task|
        task.patterns = ["#{ForemanAgentMonitoring::Engine.root}/app/**/*.rb",
                         "#{ForemanAgentMonitoring::Engine.root}/lib/**/*.rb",
                         "#{ForemanAgentMonitoring::Engine.root}/test/**/*.rb"]
      end
    rescue
      puts 'Rubocop not loaded.'
    end

    Rake::Task['rubocop_foreman_agent_monitoring'].invoke
  end
end

Rake::Task[:test].enhance ['test:foreman_agent_monitoring']

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  Rake::Task['jenkins:unit'].enhance ['test:foreman_agent_monitoring', 'foreman_agent_monitoring:rubocop']
end
