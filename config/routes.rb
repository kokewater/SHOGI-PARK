Rails.application.routes.draw do
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
  }
  namespace :admin do
    get 'top' => 'homes#top'
    resources :users, only: [:index, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :questions, only: [:index, :show, :destroy] do
      resources :answers, only: [:destroy]
    end
  end


  devise_for :users, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }

  scope module: :public do
    root 'homes#top'
    get "about" => "homes#about"
    resources :users, only: [:index, :show, :edit, :update] do
      resources :relationships, only: [:create, :destroy]
      member do
        get :quit
        get :out
      end
    end
    resources :questions do
      collection do
        get :sort
        get :search
      end
      resources :answers, only: [:create, :destroy]
      resources :likes, only: [:create, :destroy]
    end
    resources :post_messages, only: [:index, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
