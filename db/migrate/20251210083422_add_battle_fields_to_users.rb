class AddBattleFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :battle_stage, :integer, default: 1
    add_column :users, :battle_position, :integer, default: 1
    add_column :users, :stage_exp, :integer, default: 0
  end
end
