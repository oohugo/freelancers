class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.decimal :max_per_hour
      t.date :deadline
      t.string :place

      t.timestamps
    end
  end
end
