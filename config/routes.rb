Rails.application.routes.draw do
  root to: "puzzles#index"
  resources :puzzles, except: [:edit]
  get "puzzles/:id/solve" , to:"puzzles#solve", as: 'solve'
end
