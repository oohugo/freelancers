class FeedbackWorkersController < ApplicationController
  before_action :authenticate_employer!, only: :create

  def create
    @feedback_worker = FeedbackWorker.new(params.require(:feedback_worker).permit(:rating, :comment, :worker_id))
    @feedback_worker.save!
    @feedback_worker.worker.calculate_rating
    @feedback_worker.worker.save!
    flash[:notice] = 'Feedback enviado'
    redirect_to project_path(params[:project_id])
  end
end
