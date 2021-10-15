class CreateFeedbackEmployers < ActiveRecord::Migration[6.1]
  def change
    create_table :feedback_employers do |t|
      t.integer :rating
      t.string :comment
      t.references :employer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
