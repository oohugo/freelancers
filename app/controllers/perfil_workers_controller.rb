class PerfilWorkersController < ApplicationController
  before_action :authenticate_worker!, only: %i[new create edit update]
  def new
    @perfil_worker = PerfilWorker.new
  end

  def create
    @perfil_worker = PerfilWorker.new(params.require(:perfil_worker).permit(
                                        :full_name, :name, :birthdate, :qualification,
                                        :background, :expertise, :photo
                                      ))
    @perfil_worker.worker = current_worker
    if @perfil_worker.save
      redirect_to root_path
    else
      @perfil_worker.destroy
      render action: 'new'
    end
  end

  def show
    @perfil_worker = PerfilWorker.find(params[:id])
  end

  def edit
    @perfil_worker = PerfilWorker.find(params[:id])
  end

  def update
    @perfil_worker = PerfilWorker.find(params[:id])
    @perfil_worker.update(params.require(:perfil_worker).permit(:name, :qualification,
                                                                :background, :expertise, :photo))
    redirect_to root_path
  end
end
