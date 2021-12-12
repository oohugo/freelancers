class FeedbacksController < ApplicationController
  before_action :authenticate_both!, only: :create
  def create
    project = Project.find(params[:project_id])
    @feedback = project.feedbacks.new(params_feedback)
    @feedback.feedbackable = if employer_signed_in?
                               Worker.find(params[:worker_id])
                             else
                               Employer.find(params[:employer_id])
                             end
    if @feedback.save!
      flash[:notice] = 'Feedback enviado'
      redirect_to project_path(project)
    else
      render 'project/feedback'
    end
  end

  private

  def params_feedback
    params.require(:feedback).permit(:rating, :comment)
  end
end
