Rails.application.routes.draw do
  get "line_test/broadcast"
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

  #lineapi_endpoint
  post "/line_webhook", to: "line#webhook"

  #api test
  get "/line_test", to: "line_test#broadcast"
end
