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

  # ログインカレンダー（追加）
  get "login_calendar", to: "login_calendars#show"

  # アバター選択
  get  "avatar", to: "users#avatar"
  patch "avatar", to: "users#update_avatar"
  
  # LINE API
  post "/line_webhook", to: "line#webhook"
  get "/line_test", to: "line_test#broadcast"
end
