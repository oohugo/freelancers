class AddProjectReferencesToFeedback < ActiveRecord::Migration[6.1]
  def change
    add_reference :feedbacks, :project, null: false, foreign_key: true
  end
end
