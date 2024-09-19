Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             },
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             }

  namespace :api do
    namespace :v1 do
      resources :documents do
        member do
          post :share
        end
      end
      resources :comments, only: [:create]
      resources :tasks, only: [:create, :update]
    end
  end

  mount ActionCable.server => '/cable'
end
