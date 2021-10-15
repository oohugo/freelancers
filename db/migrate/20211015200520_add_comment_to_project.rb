class AddCommentToProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :comment, :string
  end
end
