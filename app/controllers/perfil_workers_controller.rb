class PerfilWorkersController < ApplicationController
  before_action :authenticate_worker!, only: %i[new create]
  def new
    @perfil_worker = PerfilWorker.new
  end

  def create
    @perfil_worker = PerfilWorker.new(params.require(:perfil_worker).permit(
                                        :full_name, :name, :birthdate, :qualification,
                                        :background, :expertise
                                      ))
    @perfil_worker.worker = current_worker
    if @perfil_worker.save
      redirect_to root_path
    else
      render action: 'new'
    end
  end

  def show
    @perfil_worker = PerfilWorker.find(params[:id])
    @rating = @perfil_worker.feedback_worker.map(&:rating)
  end
end
