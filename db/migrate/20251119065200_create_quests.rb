class CreateQuests < ActiveRecord::Migration[8.0]
  def change
    create_table :quests do |t|
      t.string :title
      t.text :description
      t.integer :exp_reward
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
