Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

   resources :groups
   resources :users
   resources :sub_requests do
      post '/send' => 'sub_requests#send_to_sendees', as: :send
      resources :sendees, only: [:show, :create, :update, :destroy] do
         resources :replies, only: [:show, :create, :update, :destroy]
      end
   end
   post '/search_classes' => 'sub_requests#search_classes', as: :search_classes

end
