Rails.application.routes.draw do
  devise_for :users, skip: :registrations

  namespace :admin do
    get "dashboard", to: "dashboard#index", as: "dashboard"
    resources :posts do
      member do
        match :preview, via: [:post, :patch] # Bypass RESTful PATCH 
      end
      collection do
        post :preview # Without :id
      end
    end
  end

  root to: redirect('/posts')

  resources :posts, only: [:index, :show]

  # Posts by category sort
  get 'posts/category/:category', to: 'posts#index', as: 'category_posts'
  
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
