class Quest < ApplicationRecord
  belongs_to :user

  before_save :calculate_exp_reward

  CATEGORY_BASE_EXP = {
    "勉強・学習" => 60,
    "仕事・作業" => 50,
    "家事・生活" => 40,
    "健康・フィットネス" => 50,
    "外出・移動" => 40,
    "用事・手続き" => 50,
    "自己管理" => 40,
    "趣味・創作" => 70,
    "人間関係" => 50,
    "金銭管理" => 40,
    "メンタルケア" => 30,
    "雑務（その他）" => 30
  }

  DIFFICULTY_VALUES = {
    "初級"   => 1.0,
    "中級"   => 2.0,
    "上級"   => 3.0,
    "超上級" => 4.0
  }

  private

  def calculate_exp_reward
    base = CATEGORY_BASE_EXP[category] || 0
    diff = DIFFICULTY_VALUES[difficulty] || 1.0
    self.exp_reward = (base * diff).to_i
  end
end
