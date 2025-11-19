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
end
