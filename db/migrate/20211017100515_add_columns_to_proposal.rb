class AddColumnsToProposal < ActiveRecord::Migration[6.1]
  def change
    add_column :proposals, :date_accepted, :date
    add_column :proposals, :comment, :string
  end
end
