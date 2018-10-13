# frozen_string_literal: true

Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users do
    post 'toggle_activity', on: :member
  end
  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :styles, only: [:index, :show]

  resource :session, only: [:new, :create, :destroy]

  

  root 'breweries#index'

  get 'kaikki_bisset', to: 'beers#index'
  get 'signup', to: 'users#new'

  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'

  resources :places, only: [:index, :show]
  # mikä generoi samat polut kuin seuraavat kaksi
  # get 'places', to:'places#index'
  # get 'places/:id', to:'places#show'
  # Pidän tuon kommentin muistissa jotta muistan
  
  post 'places', to:'places#search'

  resources :ratings, only: %i[index new create destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
