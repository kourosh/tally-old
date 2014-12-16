Rails.application.routes.draw do
  
  resources :events, except: [:new, :edit, :update, :destroy], constraints: { subdomain: 'api' }

  resources :events

  resources :search_suggestions, except: [:new, :edit], constraints: { subdomain: 'api' }

  resources :users, except: [:new, :edit], constraints: { subdomain: 'api' }

  resources :pols, except: [:new, :edit, :update, :destroy], constraints: { subdomain: 'api' }

  resources :pols
  
  post '/users/login' => 'users#attempt_login', constraints: { subdomain: 'api' }

end
