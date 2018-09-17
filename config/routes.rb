# frozen_string_literal: true

Rails.application.routes.draw do
  resources :beers
  resources :breweries

  root 'breweries#index'

  get 'kaikki_bisset', to: 'beers#index'

  resources :ratings, only: %i[index new create destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
