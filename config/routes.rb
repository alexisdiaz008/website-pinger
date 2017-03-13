Rails.application.routes.draw do

  resources :test_urls
  root 'pages#test_page'
  post 'test' => 'pages#url_test', as: :url_test
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
