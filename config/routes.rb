Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :admins

  devise_scope :posters do
    post 'posters/guest_sign_in' , to: 'posters/sessions#guest_sign_in'
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
  end
  devise_for :posters,controllers:{
    registrations: 'public/registrations',
  sessions: 'public/sessions'
  }


  namespace :admin do
    get 'reports/index'
    resources :post_photos, only: [:index,:show,:destroy]
    resources :posters, only: [:index,:show]
  end
  scope module: :public do

    resources :favorites, only: [:index,:create,:destroy]
    resources :notifications, only: [:index]
    resources :post_photos, only: [:new,:index,:show,:edit,:create,:update,:destroy] do
      get :search, on: :collection
    resource :relationships, only: [:create,:destroy]
    get 'followings' => 'relationships#following', as: 'follow'
    get 'followers' => 'relationships#follower', as: 'follower'
    end
    resources :posters, only: [:index,:show,:edit,:update]
    resources :comments, only: [:create,:destroy]
    resources :reports, only: [:new,:create]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
