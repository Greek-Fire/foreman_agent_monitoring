class AgentsController < ApplicationController
  include Foreman::Controller::AutoCompleteSearch
  include Foreman::Controller::Parameters::Agent
  
  def index
    @agents = resource_base_search_and_page
  end

  def show
    # Display individual build report.
  end

end