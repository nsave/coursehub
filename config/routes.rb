Rails.application.routes.draw do
  devise_for :users

  root 'courses#index'
  get 'tags', to: 'application#tags'
  post 'search', to: 'courses#search'
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
      get 'popular'
      get 'latest'
    end
    member do
      put 'enroll'
      put 'like'
      put 'unlike'
      get 'fork'
    end
  end
end
