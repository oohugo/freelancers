class CreateFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks do |t|
      t.integer :rating
      t.string :comment
      t.references :feedbackable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
