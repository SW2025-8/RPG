class CreateItemLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :item_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.string :action, null: false

      t.timestamps
    end
  end
end
