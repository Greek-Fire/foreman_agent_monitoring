class AgentsController < ApplicationController
  include Foreman::Controller::AutoCompleteSearch
  include Foreman::Controller::Parameters::Agent
  
  def index
    @agents = resource_base_search_and_page

    respond_to do |format|
      format.html # index.html.erb
    end
end