class EmployersController < ApplicationController
  def show
    @employer = Employer.find(params[:id])
    @rating = @employer.feedback_employer.map(&:rating)
    @projects = @employer.projects.reject(&:suspend?)
  end
end
