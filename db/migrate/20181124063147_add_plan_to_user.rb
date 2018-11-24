class AddPlanToUser < ActiveRecord::Migration[5.0]
  def change
    # Add a column to the Users table
    # This column should be called plan_id
    # And it should be an integer (1 for Basic, 2 for Pro)
    add_column :users, :plan_id, :integer
  end
end
