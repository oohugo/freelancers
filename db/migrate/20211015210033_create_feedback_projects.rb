class CreateFeedbackProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :feedback_projects do |t|
      t.string :comment
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
