Rails.application.routes.draw do
  devise_for :users

  # ホーム
  root to: "home#index"

  # クエスト
  resources :quests do
    member do
      patch :complete
    end
  end

  # マイページ
  get "mypage", to: "users#mypage", as: :mypage

  # ショップ
  get  "shop", to: "shop#index", as: :shop
  post "shop/buy/:item_id", to: "shop#buy", as: :buy_item

  # 持ち物
  get  "inventory", to: "inventory#index", as: :inventory
  post "inventory/use/:id", to: "inventory#use", as: :use_item

  # アバター
  get  "avatar", to: "users#avatar"
  patch "avatar", to: "users#update_avatar"

  # LINE API
  post "/line_webhook", to: "line#webhook"
end
