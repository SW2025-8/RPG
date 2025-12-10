class AddDifficultyToQuests < ActiveRecord::Migration[7.0]
  def change
    add_column :quests, :difficulty, :string
  end
end
