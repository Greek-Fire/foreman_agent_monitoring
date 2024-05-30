class AgentsController < ApplicationController
  include Foreman::Controller::AutoCompleteSearch
  include Foreman::Controller::Parameters::Agent
  
  before_action :find_resource, :only => [:edit, :update, :destroy]

  def index
    @agents = resource_base_search_and_page
  end
end