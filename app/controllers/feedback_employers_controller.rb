class FeedbackEmployersController < ApplicationController
  def create
    @feedback_employer = FeedbackEmployer.new(params.require(:feedback_employer).permit(:rating, :comment))
    project = Project.find(params[:project_id])
    @feedback_employer.employer = project.employer
    FeedbackProject.create!(comment: params[:comment_project], project: project)
    @feedback_employer.save!

    flash[:alert] = 'Feedback enviado'
    redirect_to feedback_project_path(params[:project_id])
  end
end
