module ApplicationHelper
  # 10分ごとに背景を変更する
  def timed_background_image
    backgrounds = ["bg1.png", "bg2.png", "bg3.png"]

    minute = Time.now.min

    # 10分ごとに切り替え
    index = (minute / 10) % backgrounds.size

    backgrounds[index]
  end
end
