Rails.application.routes.draw do

    devise_for :admins
    devise_for :users, :controllers => { registrations: 'registrations' }

    resources :transactions

    resources :payment_methods do
        collection do
            get "/check" => "payment_methods#check"
        end
    end

    namespace :api, path: 'api/' do
        resources :search_suggestions, :users, :pacs
        resources :pols, :events do
            post '/comments' => 'comments#create', as: 'comments'
            post '/favorites' => 'favorites#create', as: 'favorites'
            delete '/favorites/:id' => 'favorites#destroy', as: 'remove_favorites'
        end
    end
    root to: "events#index"

    resources :events do
        post '/comments' => 'comments#create', as: 'comments'
        post '/favorites' => 'favorites#create', as: 'favorites'
        delete '/favorites/:id' => 'favorites#destroy', as: 'remove_favorites'

        collection do
            post '/get_info' => 'events#get_info'
        end
    end

    resources :search_suggestions, except: [:new, :edit]

    resources :users, except: [:new, :edit]

    resources :pacs do
        collection do
            get "confirm" => "pacs#confirm"
        end
    end

    resources :pols do
        post '/comments' => 'comments#create', as: 'comments'
        post '/favorites' => 'favorites#create', as: 'favorites'
        delete '/favorites/:id' => 'favorites#destroy', as: 'remove_favorites'
    end


    post '/api/users/signup' => 'api/users#create'

    post '/api/users/login' => 'api/users#attempt_login'

    post '/api/support' => 'api/voting#support'

    post '/api/oppose' => 'api/voting#oppose'

    get '/settings' => 'users#settings_index'
end
