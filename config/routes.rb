Rails.application.routes.draw do
  
	namespace :api, path: 'api/' do
  	resources :events, :search_suggestions, :users, :pols
	end

  namespace :admin do 
    resources :events

    resources :search_suggestions, except: [:new, :edit]

    resources :users, except: [:new, :edit]

    resources :pols
  end
  
  post '/users/signup' => 'users#create'

  post '/users/login' => 'users#attempt_login'
  
end
