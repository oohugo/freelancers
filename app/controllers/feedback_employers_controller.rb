class FeedbackEmployersController < ApplicationController
  before_action :authenticate_worker!, only: :create
  def create
    @feedback_employer = FeedbackEmployer.new(params.require(:feedback_employer).permit(:rating, :comment))
    project = Project.find(params[:project_id])
    @feedback_employer.employer = project.employer
    FeedbackProject.create!(comment: params[:comment_project], project: project)
    @feedback_employer.save!
    @feedback_employer.employer.calculate_rating
    @feedback_employer.employer.save!
    flash[:notice] = 'Feedback enviado'
    redirect_to project_path(params[:project_id])
  end
end
