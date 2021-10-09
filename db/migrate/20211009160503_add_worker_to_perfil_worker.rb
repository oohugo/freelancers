class AddWorkerToPerfilWorker < ActiveRecord::Migration[6.1]
  def change
    add_reference :perfil_workers, :worker, null: false, foreign_key: true
  end
end
