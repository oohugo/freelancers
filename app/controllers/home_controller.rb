class HomeController < ApplicationController
  def index
    redirect_to new_perfil_worker_path if worker_signed_in? && current_worker.perfil_worker.nil?
    @projects = Project.all
  end
end
