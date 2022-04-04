Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'search/:name', to: 'apps#search'
      resources :apps, param: :token,only: [:index, :create] do
        scope module: :apps do
          resources :chats, param: :number, only: [:index, :create] do
            scope module: :chats do
              resources :messages, only: [:index, :create]
              get 'search/:content', to: 'messages#search'
            end
          end
        end
      end
    end
  end
end
