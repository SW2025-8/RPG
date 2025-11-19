class AddAvatarTypeToUsers < ActiveRecord::Migration[7.1]
  def change
    # アバターの種類（"warrior": 戦士 など）
    add_column :users, :avatar_type, :string, default: "warrior"
  end
end
