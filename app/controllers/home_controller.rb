class HomeController < ApplicationController
  def index
    if worker_signed_in?
      if current_worker.perfil_worker.nil?
        redirect_to new_perfil_worker_path
      else
        @projects = Project.where(status: :avaliable)
      end
    end
    @projects = current_employer.projects if employer_signed_in?
  end
end
