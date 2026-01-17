class AddImageNameToItems < ActiveRecord::Migration[8.0]
  def change
    add_column :items, :image_name, :string, null: false
  end
end
