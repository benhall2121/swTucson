SwTucson::Application.routes.draw do
  match 'user/edit' => 'users#edit', :as => :edit_current_user
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  match 'about_us' => 'users#about_us', :as => :about_us

  resources :sessions

  resources :users
  
  root :to => "users#home"

end
