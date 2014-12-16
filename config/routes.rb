Rails.application.routes.draw do
  
	namespace :api, path: '/' do
  	resources :events, :search_suggestions, :users, :pols
	end



  resources :events, except: [:new, :edit, :update, :destroy]

  resources :events

  resources :search_suggestions, except: [:new, :edit]

  resources :users, except: [:new, :edit]

  resources :pols, except: [:new, :edit, :update, :destroy]

  resources :pols
  
  post '/users/signup' => 'users#create'

  post '/users/login' => 'users#attempt_login'
  
end
