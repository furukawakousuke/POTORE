Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :admins, skip: [:registrations, :passwords], controllers:{
  sessions: 'admin/sessions'
}

  devise_scope :posters do
    post 'posters/guest_sign_in' , to: 'posters/sessions#guest_sign_in'
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
  end
  devise_for :posters,controllers:{
    registrations: 'public/registrations',
  sessions: 'public/sessions'
  }


  namespace :admin do
    resources :post_photos, only: [:index,:show,:destroy]
    resources :posters, only: [:index,:show]
    get 'sending/:id' => 'reports#sending',as: 'sending'
    resources :reports, only: [:index,:show,:update,:destroy]
  end
  scope module: :public do

    resources :notifications, only: [:index] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :post_photos, only: [:new,:index,:show,:edit,:create,:update,:destroy] do
      get :search, on: :collection
      resource :favorites, only: [:create,:destroy]
      resources :comments, only: [:create,:destroy]
    resources :reports, only: [:new,:create]
    end
    resources :posters, only: [:index,:show,:edit,:update] do
    get :search, on: :collection
      resource :favorites, only: [:create,:destroy]
    resource :relationships, only: [:create,:destroy]
    get 'followings' => 'relationships#followings', as: 'follow'
    get 'followers' => 'relationships#followers', as: 'follower'
      member do
       get :favorites
      end
    end

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
