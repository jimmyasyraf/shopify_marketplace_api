Rails.application.routes.draw do
  resources :products, only: [:index, :create, :show] do
    member do
      get :restock
    end
  end
end
