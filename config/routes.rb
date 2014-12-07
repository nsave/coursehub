Rails.application.routes.draw do
  devise_for :users

  root 'courses#index'
  resources :courses do
    resources :course_items, path: 'items', except: [:index, :show]
    collection do
      get 'own'
      get 'learning'
    end
    member do
      put 'enroll'
    end
  end
end
