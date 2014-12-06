Rails.application.routes.draw do
  devise_for :users

  root 'main#index'
  resources :courses do
    resources :course_items, path: 'items', except: [:index, :show]
  end
end
