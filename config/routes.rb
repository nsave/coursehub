Rails.application.routes.draw do
  devise_for :users

  root 'courses#index'
  resources :courses do
    resources :course_items, path: 'items', except: [:index, :show] do
      member do
        put 'learn'
        put 'unlearn'
      end
    end
    collection do
      get 'own'
      get 'learning'
      get 'filter/:tag' , to: 'courses#filter', as: 'filter'
    end
    member do
      put 'enroll'
      put 'like'
      put 'unlike'
    end
  end
end
