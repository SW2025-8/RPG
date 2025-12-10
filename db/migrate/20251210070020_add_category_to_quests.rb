class AddCategoryToQuests < ActiveRecord::Migration[8.0]
  def change
    add_column :quests, :category, :string
    add_column :quests, :subcategory, :string
  end
end
