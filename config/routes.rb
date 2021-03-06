Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/:id' => 'short_links#show'
  resources :short_links, only: [:show]

  post '/:id' => 'short_links#create'
  resources :short_links, only: [:create]
end
