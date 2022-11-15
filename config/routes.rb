Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :portfolios, only: %i[index show] do
    collection do
      get 'upload_data'
      post 'synchronize'
    end
  end

  resources :groups, defaults: { format: :json }, only: [] do
    member do
      get 'states'
    end
  end
  # Defines the root path route ("/")
  root "portfolios#index"
end
