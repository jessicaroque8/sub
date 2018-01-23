Rails.application.routes.draw do
   resources :groups
   resources :users
   resources :sub_requests

   post '/search_classes' => 'sub_requests#search_classes', as: :search_classes

end
