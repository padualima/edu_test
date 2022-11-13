Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :portfolios, only: %i[index] do
    collection do
      get 'upload_data'
      post 'synchronize'
    end
  end
  # Defines the root path route ("/")
  root "portfolios#index"
end
