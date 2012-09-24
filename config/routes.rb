Wmusicapp::Application.routes.draw do
  get "albums/index"

  get "albums/new"

  get "albums/create"

  get "albums/search"

  get "sessions/new"

  get "sessions/create"

  get "sessions/destroy"

  get "users/new"

  get "users/create"

  get "signup" => "users#new"
  get "signin"  => "sessions#new"
  get "signout"  => "sessions#destroy"

  resources :users

  resources :sessions

  resources :albums do 
    collection do
      post :search
    end
  end

  root :to => 'sessions#new'

end
