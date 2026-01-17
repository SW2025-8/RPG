class AddTotalExpToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :total_exp, :integer, default: 0, null: false
  end
end
