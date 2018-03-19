Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

   resources :groups
   resources :users
   resources :sub_requests do
      resources :selected_sub
      resources :sendees do
         resources :reply
      end
   end
   post '/search_classes' => 'sub_requests#search_classes', as: :search_classes
   post '/link_to_mb' => 'users#link_to_mb', as: :link_to_mb
end
