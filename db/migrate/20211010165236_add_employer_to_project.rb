class AddEmployerToProject < ActiveRecord::Migration[6.1]
  def change
    add_reference :projects, :employer, null: false, foreign_key: true
  end
end
