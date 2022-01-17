Rails.application.routes.draw do
  root 'pokemons#index'
  resources :types
  resources :abilities
  resources :pokemons
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
