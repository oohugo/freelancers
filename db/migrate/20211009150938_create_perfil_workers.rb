class CreatePerfilWorkers < ActiveRecord::Migration[6.1]
  def change
    create_table :perfil_workers do |t|
      t.string :full_name
      t.string :name
      t.date :birthdate
      t.string :qualification
      t.string :background
      t.string :expertise

      t.timestamps
    end
  end
end
