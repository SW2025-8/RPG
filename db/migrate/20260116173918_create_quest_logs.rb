class CreateQuestLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :quest_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :exp, null: false

      t.timestamps
    end
  end
end
