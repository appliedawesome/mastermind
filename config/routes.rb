Mastermind::Application.routes.draw do
  authenticated :user do 
    root :to => 'home#index'
  end
  
  root :to => 'home#index'
  
  devise_for :users
  
  as :user do
    get '/sign_in' => 'devise/sessions#new'
    delete '/sign_out' => 'devise/sessions#destroy'
    get '/sign_up' => 'devise/registrations#new'
  end

  # resources :users, :only => [ :show, :index ]
  
  resources :heists do
    resources :jobs
  end
  

end
