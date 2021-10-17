class AddRatingToWorker < ActiveRecord::Migration[6.1]
  def change
    add_column :workers, :rating, :integer
  end
end
