class AddStatsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :level, :integer, default: 1
    add_column :users, :exp, :integer, default: 0
  end
end
