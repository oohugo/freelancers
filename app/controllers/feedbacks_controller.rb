class FeedbacksController < ApplicationController
  before_action :authenticate_both!, only: :create
  def create
    @feedback = Feedback.new(params.require(:feedback).permit(:rating, :comment))
    @feedback.project_id = params[:project_id]
    if employer_signed_in?
      @feedback.feedbackable = Worker.find(params[:worker_id])
    else
      @feedback.feedbackable = Employer.find(params[:employer_id])
    end
    if @feedback.save!
      flash[:notice] = 'Feedback enviado'
      redirect_to project_path(params[:project_id])
    else
      render 'project/feedback'
    end
  end
end
