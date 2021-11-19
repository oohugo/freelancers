class HomeController < ApplicationController
  before_action :authenticate_perfil, only: :index

  def index
    if worker_signed_in?
      @projects = Project.where(status: :avaliable)
      @projects_worker = current_worker.projects
      @projects = @projects.to_a.difference(@projects_worker) unless @projects.nil?
    end
    @projects = current_employer.projects if employer_signed_in?
  end
end
