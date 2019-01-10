Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :create, :show] do
        member do
          get :restock
        end
      end
    end
  end
end
