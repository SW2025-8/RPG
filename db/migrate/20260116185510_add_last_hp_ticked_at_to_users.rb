class AddLastHpTickedAtToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :last_hp_ticked_at, :datetime
  end
end
