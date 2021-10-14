class CreateFeedbackWorkers < ActiveRecord::Migration[6.1]
  def change
    create_table :feedback_workers do |t|
      t.integer :rating
      t.string :comment
      t.references :worker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
