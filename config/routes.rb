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

  # アバター選択（表示）
  get  "avatar", to: "users#avatar"

  # アバター更新（編集保存）
  patch "avatar", to: "users#update_avatar"
end
