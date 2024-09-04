Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :documents, only: [:index, :show, :create, :update]
      resources :comments, only: [:create]
      resources :tasks, only: [:create, :update]
    end
  end

  mount ActionCable.server => '/cable'
end
