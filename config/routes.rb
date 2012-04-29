Mastermind::Application.routes.draw do
  get "jobs/index"

  get "jobs/show"

  get "jobs/new"

  get "jobs/edit"

  resources :heists do
    resources :jobs
  end
  

end
