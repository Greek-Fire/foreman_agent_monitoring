module ForemanAgentMonitoring
  class Agent < ApplicationRecord
    scoped_search on: :network, complete_value: true
    scoped_search on: :status, complete_value: true
    scoped_search on: :agent, complete_value: true
    scoped_search on: :host
  end
end