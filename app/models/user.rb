class User < ApplicationRecord
  # Devise モジュール
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :quests, dependent: :destroy

  # ★経験値を加算してレベルアップ処理を行うメソッド
  def gain_exp(amount)
    self.exp ||= 0
    self.level ||= 1

    self.exp += amount

    # 100 EXP でレベルアップ
    while self.exp >= 100
      self.exp -= 100
      self.level += 1
    end

    save
  end
end
