Rails.application.routes.draw do
  root 'pokemons#index'
  resources :types
  resources :abilities
  resources :pokemons
  
  resources :pokemons do 
    member do 
      put :addAbility
      put :addType
      delete :deleteAbility
      delete :deleteType
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
