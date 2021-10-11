class PerfilWorkersController < ApplicationController
  def new
    @perfil_worker = PerfilWorker
  end

  def create
    perfil_worker = PerfilWorker.new(params.require(:perfil_worker).permit(
                                       :full_name, :name, :birthdate, :qualification,
                                       :backgound, :expertise
                                     ))
    perfil_worker.worker = current_worker
    perfil_worker.save!
    redirect_to root_path
  end

  def show
    @perfil_worker = PerfilWorker.find(params[:id])
  end 
end
