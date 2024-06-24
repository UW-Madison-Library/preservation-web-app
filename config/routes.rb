Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'organizations#index'
  get 'organizations', to: 'organizations#index'

  resources :organizations do
    resources :batches, only: %i[index new create]
    resources :vaults, only: %i[index new create]
  end

  get '/vaults/:id', to: 'vaults#show', as: 'vault'

  resources :batches, only: %i[show edit update]
  resources :batches do
    resources :batch_objects, as: :objects, only: %i[index]
  end

  resources :vaults do
    get 'preservation_objects/display', to: 'preservation_objects#display'
  end
end
