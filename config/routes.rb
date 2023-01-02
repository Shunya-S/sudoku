Rails.application.routes.draw do
  root to: "puzzles#index"
  resources :puzzles, except: [:edit]
  patch "puzzles/:id/solve" , to:"puzzles#solve", as: 'solve'
end
