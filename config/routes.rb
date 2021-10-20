Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users,
             defaults: { format: :json },
             controllers: {
               # confirmations: 'confirmations',
               # passwords: 'passwords',
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
end
