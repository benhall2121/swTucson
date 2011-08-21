SwTucson::Application.routes.draw do
  resources :events

  match 'user/edit' => 'users#edit', :as => :edit_current_user
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  match 'about_us' => 'users#about_us', :as => :about_us
  match 'qr_code/:id' => 'users#qr_code', :as => :qr_code
  match 'donate_paypal/:id' => 'users#donate_paypal', :as => :donate_paypal

  resources :sessions

  resources :users
  
  root :to => "users#home"

end
