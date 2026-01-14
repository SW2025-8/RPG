class CreateLoginLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :login_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.date :login_date

      t.timestamps
    end
  end
end
