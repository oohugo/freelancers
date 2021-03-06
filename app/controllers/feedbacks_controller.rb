class FeedbacksController < ApplicationController
  before_action :authenticate_both!, only: :create
  def create
    @project = Project.find(params[:project_id])
    @feedback = @project.feedbacks.new(params_feedback)
    @feedback.feedbackable = feedbackable_get
    if @feedback.save
      flash[:notice] = 'Feedback enviado'
      redirect_to project_path(@project)
    else
      @workers = @project.proposals.select(&:accepted?).map(&:worker) if employer_signed_in?
      render 'projects/feedback'
    end
  end

  private

  def params_feedback
    params.require(:feedback).permit(:rating, :comment)
  end

  def feedbackable_get
    employer_signed_in? ? Worker.find(params[:worker_id]) : Employer.find(params[:employer_id])
  end
end
