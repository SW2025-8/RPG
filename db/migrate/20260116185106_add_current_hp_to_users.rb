class AddCurrentHpToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :current_hp, :integer
  end
end
