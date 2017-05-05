Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :categories
    resources :jobs do
      member do
        post :publish
        post :hide
      end
      resources :resumes
    end
  end

  resources :jobs do
    resources :resumes
    collection do
        get :search
    end
  end

  namespace :account do
    resources :favorites, only: [:index]
  end

  resources :favorites, only: [:create, :destroy]

  root 'welcome#index'
end
