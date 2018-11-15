Rails.application.routes.draw do
  root to: 'pages#home' # Root is like a HOME PAGE; HOME ACTION/METHOD
  # This ROUTES file is the 1st file that gets activated
  get  'about', to: 'pages#about' # pages#about refers to the About METHOD in PAGES CONTROLLER
  resources :contacts
  get 'contact-us', to: 'contacts#new'
end
