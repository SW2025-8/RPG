class Quest < ApplicationRecord
  belongs_to :user

  before_save :calculate_exp_reward

  CATEGORY_BASE_EXP = {
    "勉強・学習" => 100,
    "家事・生活" => 40,
    "仕事・作業" => 120,
    "健康・フィットネス" => 60,
    "用事・手続き" => 50,
    "自己管理" => 40,
    "趣味・創作" => 60,
    "人間関係・コミュニケーション" => 40,
    "金銭管理" => 40,
    "メンタルケア" => 40,
    "外出・移動" => 30,
    "雑務（その他）" => 20
  }

  DIFFICULTY_VALUES = {
    "初級" => 1.0,
    "中級" => 1.5,
    "上級" => 2.0,
    "超上級" => 2.5
  }

  private

  def calculate_exp_reward
    base = CATEGORY_BASE_EXP[category] || 10
    diff = DIFFICULTY_VALUES[difficulty] || 1.0
    self.exp_reward = (base * diff).to_i
  end
end
