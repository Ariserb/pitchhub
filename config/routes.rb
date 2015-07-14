# The priority is based upon order of creation: first created -> highest priority.
# See how all your routes lay out with "rake routes".

Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :pitch_cards, except: :index  do
    collection do
      get :initiated, :collabs, :search
    end
    member do
      post :complete, :activate
    end
    resources :comments, only: [:index, :new, :create, :update, :destroy, :initiator_scope] do
      member do
        post 'initiator_scope'
      end
    end
    resources :suggestions, only: [:index, :new, :create, :update, :destroy, :accept] do
      member do
        post 'accept'
      end
    end
  end

  authenticated :user do
    root :to => "dashboard#index", as: :authenticated_root
  end

  root 'welcome#index'

end
