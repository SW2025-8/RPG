class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :quests, dependent: :destroy
  has_many :login_logs, dependent: :destroy
  has_many :quest_logs, dependent: :destroy
  has_many :user_items, dependent: :destroy
  has_many :items, through: :user_items
  has_many :item_logs, dependent: :destroy

  # =========================
  # レベル / EXP
  # =========================

  BASE_LEVEL_UP_EXP = 150
  LEVEL_EXP_GROWTH  = 50

  def exp_to_next_level
    BASE_LEVEL_UP_EXP + (level - 1) * LEVEL_EXP_GROWTH
  end

  def add_exp(amount)
    self.exp ||= 0
    self.level ||= 1
    self.total_exp ||= 0

    self.total_exp += amount
    self.exp += amount

    while self.exp >= exp_to_next_level
      self.exp -= exp_to_next_level
      self.level += 1
    end

    save!
  end

  def exp_rate
    ((exp.to_f / exp_to_next_level) * 100).to_i
  end

  # =========================
  # プレイヤーHP（半ハート制）
  # =========================

  MAX_HP = 10
  # ★ デバッグ用10秒 → 本番用7.2時間（25,920秒）
  HP_INTERVAL_SECONDS = (7.2 * 60 * 60).to_i

  after_initialize :normalize_player_hp
  after_initialize :set_default_timers, if: :new_record?

  def apply_time_hp_damage!
    now = Time.current

    if last_hp_ticked_at.nil?
      update!(last_hp_ticked_at: now)
      return
    end

    elapsed_seconds = (now - last_hp_ticked_at).to_i
    ticks = elapsed_seconds / HP_INTERVAL_SECONDS
    return if ticks <= 0

    self.hp = [[hp - ticks, 0].max, MAX_HP].min
    self.last_hp_ticked_at = last_hp_ticked_at + ticks * HP_INTERVAL_SECONDS

    save!
  end

  # =========================
  # 敵バトルロジック
  # =========================

  def enemy_max_hp
    100 + (battle_stage - 1) * 20 + (battle_position - 1) * 8
  end

  def reset_enemy_hp!
    self.current_hp = enemy_max_hp
    save!
  end

  def deal_damage_to_enemy!(damage)
    self.current_hp = enemy_max_hp if current_hp.nil?
    self.current_hp -= damage

    if current_hp <= 0
      defeat_enemy!
    else
      save!
    end
  end

  def defeat_enemy!
    self.battle_position += 1

    if battle_position > 5
      self.battle_stage += 1
      self.battle_position = 1
      self.stage_exp = 0
    end

    self.current_hp = enemy_max_hp
    save!
  end

  # =========================
  # 表示系
  # =========================

  def avatar_image
    case avatar_type
    when "warrior" then "騎士.png"
    when "mage"    then "魔法使い.png"
    when "priest"  then "僧侶.png"
    when "thief"   then "盗賊.png"
    else
      "騎士.png"
    end
  end

  # =========================
  # クエストEXP計算（作成時用）
  # =========================

  BASE_EXP_TABLE = {
    "勉強・学習" => { "初級" => 60, "中級" => 120, "上級" => 200, "超上級" => 300 },
    "仕事・作業" => { "初級" => 50, "中級" => 100, "上級" => 160, "超上級" => 240 },
    "家事・生活" => { "初級" => 40, "中級" => 80,  "上級" => 120, "超上級" => 180 },
    "健康・フィットネス" => { "初級" => 50, "中級" => 100, "上級" => 160, "超上級" => 240 },
    "外出・移動" => { "初級" => 40, "中級" => 80,  "上級" => 120, "超上級" => 180 },
    "用事・手続き" => { "初級" => 50, "中級" => 100, "上級" => 160, "超上級" => 240 },
    "自己管理" => { "初級" => 40, "中級" => 80,  "上級" => 120, "超上級" => 180 },
    "趣味・創作" => { "初級" => 70, "中級" => 140, "上級" => 220, "超上級" => 320 },
    "人間関係・コミュニケーション" => { "初級" => 50, "中級" => 100, "上級" => 160, "超上級" => 240 },
    "金銭管理" => { "初級" => 40, "中級" => 80,  "上級" => 120, "超上級" => 180 },
    "メンタルケア" => { "初級" => 30, "中級" => 60,  "上級" => 100, "超上級" => 150 },
    "雑務（その他）" => { "初級" => 30, "中級" => 60,  "上級" => 100, "超上級" => 150 }
  }

  AVATAR_TRAITS = {
    "warrior" => { good: ["健康・フィットネス", "外出・移動"], bad: ["勉強・学習", "金銭管理"] },
    "mage"    => { good: ["勉強・学習", "趣味・創作"], bad: ["健康・フィットネス", "外出・移動"] },
    "priest"  => { good: ["家事・生活", "メンタルケア", "人間関係・コミュニケーション"], bad: ["仕事・作業", "趣味・創作"] },
    "thief"   => { good: ["雑務（その他）", "用事・手続き", "金銭管理"], bad: ["メンタルケア", "人間関係・コミュニケーション"] }
  }

  def calculate_quest_exp(quest)
    base = BASE_EXP_TABLE.dig(quest.category, quest.difficulty) || 0
    traits = AVATAR_TRAITS[avatar_type] || { good: [], bad: [] }

    rate =
      if traits[:good].include?(quest.category)
        0.85
      elsif traits[:bad].include?(quest.category)
        1.20
      else
        1.00
      end

    (base * rate).to_i
  end

  private

  def normalize_player_hp
    self.hp = MAX_HP if hp.nil? || hp > MAX_HP
    self.hp = 0 if hp < 0
  end

  def set_default_timers
    self.last_hp_ticked_at ||= Time.current
  end
end
