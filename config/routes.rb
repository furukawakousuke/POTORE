Rails.application.routes.draw do
  root to: 'homes#top'
  namespace :admin do
    get 'reports/index'
    resources :post_photos, only: [:index,:show,:destroy]
    resources :posters, only: [:index,:show]
  end
  scope module: :public do
    get 'rerlationships/follow'
    get 'rerlationships/follower'
    resources :relationships, only: [:create,:destroy]
    resources :favorites, only: [:index,:create,:destroy]
    resources :notifications, only: [:index]
    resources :post_photos, only: [:new,:index,:show,:edit,:create,:update,:destroy]
    resources :posters, only: [:show,:edit,:update]
    resources :comments, only: [:create,:destroy]
    resources :reports, only: [:new,:create]
  end
  devise_for :admins
  devise_scope :posters do
    post 'posters/guest_sign_in' , to: 'poster/sessions#guest_sign_in'
  end
  post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
  devise_for :posters, controllers: {
    registrations: 'posters/registrations',
    passwards: 'posters/passwards'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
