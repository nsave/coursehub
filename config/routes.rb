Rails.application.routes.draw do
  devise_for :users

  root 'courses#index'
  resources :courses do
    resources :course_items, path: 'items', except: [:index, :show]
  end
end
