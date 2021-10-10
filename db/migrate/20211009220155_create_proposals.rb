class CreateProposals < ActiveRecord::Migration[6.1]
  def change
    create_table :proposals do |t|
      t.string :description
      t.decimal :hourly_value
      t.integer :hours_per_week
      t.date :date_close
      t.references :project, null: false, foreign_key: true
      t.references :worker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
