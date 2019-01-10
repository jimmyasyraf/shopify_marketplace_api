Rails.application.routes.draw do
  get '/docs' => redirect('/index.html')

  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :create, :show] do
        member do
          post :restock
        end
      end
    end
  end
end
