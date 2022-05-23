Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  root 'pokemons#index'
  resources :types
  resources :abilities
  resources :pokemons

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
  end
  
  resources :pokemons do 
    member do 
      put :add_ability
      put :add_type
      delete :delete_ability
      delete :delete_type
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
