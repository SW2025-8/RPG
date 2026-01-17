class AddDueDateToQuests < ActiveRecord::Migration[8.0]
  def change
    add_column :quests, :due_date, :date
    add_index  :quests, :due_date
  end
end
