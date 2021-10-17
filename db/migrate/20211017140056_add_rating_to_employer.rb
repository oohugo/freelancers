class AddRatingToEmployer < ActiveRecord::Migration[6.1]
  def change
    add_column :employers, :rating, :integer
  end
end
