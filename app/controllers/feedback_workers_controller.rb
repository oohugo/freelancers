class FeedbackWorkersController < ApplicationController
  before_action :authenticate_employer!, only: :create
  def create
    @feedback_worker = FeedbackWorker.new(params.require(:feedback_worker).permit(:rating, :comment, :worker_id))
    @feedback_worker.save!
    flash[:alert] = 'Feedback enviado'
    redirect_to feedback_project_path(params[:project_id])
  end
end
