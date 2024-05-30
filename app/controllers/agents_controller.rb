class AgentsController < ApplicationController
  include Foreman::Controller::AutoCompleteSearch
  include Foreman::Controller::Parameters::Agent
  
  def index
    @agents
    end
end