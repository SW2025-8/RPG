class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :quests, dependent: :destroy

  def add_exp(amount)
    self.exp += amount

    while self.exp >= 100
      self.exp -= 100
      self.level += 1
    end

    save
  end

  # avatar_type → 画像ファイル名
  def avatar_image
    case avatar_type
    when "warrior" then "騎士.png"
    when "mage"  then "魔法使い.png"
    when "priest"  then "僧侶.png"
    when "thief"   then "盗賊.png"
    else
      "騎士.png"
    end
  end
end
