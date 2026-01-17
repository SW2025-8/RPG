Item.find_or_create_by!(name: "回復薬") do |item|
  item.price = 5
  item.effect_type = "heal_one"
  item.image_name = "heal_potion.png"
end

Item.find_or_create_by!(name: "すごい回復薬") do |item|
  item.price = 30
  item.effect_type = "heal_full"
  item.image_name = "super_heal_potion.png"
end

Item.find_or_create_by!(name: "復活の書") do |item|
  item.price = 50
  item.effect_type = "revive"
  item.image_name = "revive_scroll.png"
end
