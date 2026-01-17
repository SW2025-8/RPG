class Item < ApplicationRecord
  has_many :user_items, dependent: :destroy
  has_many :users, through: :user_items

  validates :name, presence: true
  validates :price, presence: true
  validates :effect_type, presence: true
end
