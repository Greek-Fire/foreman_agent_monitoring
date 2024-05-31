require 'test_plugin_helper'

class ForemanAgentMonitoringTest < ActiveSupport::TestCase
  setup do
    User.current = User.find_by_login 'admin'
  end

  test 'the truth' do
    assert true
  end
end
