class HomeController < ApplicationController
  def index
    if worker_signed_in?
      if current_worker.perfil_worker.nil?
        redirect_to new_perfil_worker_path
      else
        @projects = Project.where(status: :avaliable)
        @projects_worker = current_worker.projects
        @projects = @projects.to_a.difference(@projects_worker) unless @projects.nil?
      end
    end
    @projects = current_employer.projects if employer_signed_in?
  end
end
