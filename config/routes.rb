Rails.application.routes.draw do
  get '/docs' => redirect('/index.html')

  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :create, :show] do
        member do
          post :restock
        end
      end

      resources :carts, only: [:show]

      resources :cart_items, only: [:create, :update, :destroy]
    end
  end
end
