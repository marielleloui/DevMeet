Rails.application.routes.draw do
  # This ROUTES file is the 1st file that gets activated
  root to: 'pages#home' # Root is like a HOME PAGE; HOME ACTION/METHOD
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users do
    resource :profile
  end
  get  'about', to: 'pages#about' # pages#about refers to the About METHOD in PAGES CONTROLLER
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
end
