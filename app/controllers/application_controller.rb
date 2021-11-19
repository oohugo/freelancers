class ApplicationController < ActionController::Base
  private

  def authenticate_both!
    return if worker_signed_in? || employer_signed_in?

    redirect_to root_path, alert: 'É necessário fazer login'
  end

  def authenticate_perfil
    return unless current_worker&.perfil_worker.nil? && worker_signed_in?

    redirect_to new_perfil_worker_path, alert: 'É necessário criar perfil para ver projetos'
  end
end
