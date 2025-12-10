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

  # アバター選択
  get  "avatar", to: "users#avatar"
  patch "avatar", to: "users#update_avatar"
end
