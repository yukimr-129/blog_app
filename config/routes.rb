Rails.application.routes.draw do
  get 'articles/index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get  'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
  end

  $date = Time.now.in_time_zone('Tokyo').to_s
  root "articles#index"
  resources :articles

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
