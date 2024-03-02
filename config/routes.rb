Rails.application.routes.draw do
  get 'payments/index'
  get 'payments/new'
  get 'payments/create'
  devise_for :users, path: '',
                     path_names: {
                      sign_in: 'login',
                      sign_out: 'logout',
                      password: 'pass',
                      confirmation: 'confirm',
                      unlock: 'activate',
                      registration: '',
                      sign_up: 'signup'
                    }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # to access categories(home) the user needs to login first (authenticate)
  authenticate :user do
    resources :categories, only: %i[index new create], constraints: { id: /[1-9]+[0-9]*/ } do
      resources :payments, only: %i[index new create]
    end
  end

  # splash route
  get 'splash', to: 'screens#splash', as: 'splash_screen'

  # when the user has logged in(authenticated) the root path is 'categories#index'
  authenticated :user do
    root to: 'categories#index', as: :authenticated_root
  end

  # if there is no user logged in the root path is the splash screen
  root to: 'screens#splash'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
