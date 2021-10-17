class EmployersController < ApplicationController
  def show
    @employer = Employer.find(params[:id])
    @projects = @employer.projects.reject(&:suspend?)
  end
end
