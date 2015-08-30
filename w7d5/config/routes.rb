TrelloApp::Application.routes.draw do
  root to: "static_pages#index"

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  namespace :api, defaults: {format: :json} do
    resources :boards, only: [:index, :show, :create, :update, :destroy] do
      resources :lists, only: [:index, :create, :update, :destroy] do
        resources :cards, only: [:index, :create, :update, :destroy]
      end
    end

    resources :lists, only: [:show]
    resources :cards, only: [:show]
  end
end
