class EmployersController < ApplicationController
  before_action :authenticate_worker!, only: :show
  def show
    @employer = Employer.find(params[:id])
    @projects = @employer.projects.reject(&:suspend?)
  end
end
