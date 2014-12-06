Rails.application.routes.draw do
  devise_for :users

  root 'main#index'
  get 'app' => 'main#app'

  resources :courses do
    resources :course_items, path: 'items'
  end
end
