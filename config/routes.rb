AdvancedStudyRoom::Application.routes.draw do

  #
  # Devise
  #

  # TODO: Remove dups and generate more readable routes for devise.
  # Look at the devise routes from the 'rake routes' list.
  devise_for :users, controllers: {registrations: :signup} do
    get  'login',     to: 'devise/sessions#new',        as: 'login'
    post 'login',     to: 'devise/sessions#create'
    get  'logout',    to: 'devise/sessions#destroy',    as: 'logout'
    get  'signup',    to: 'signup#new',                 as: 'signup'
    post 'signup',    to: 'signup#create'
  end

  #
  # Users
  #

  get 'profile',                   to: 'users#show'
  get 'users/:id/accounts/new',    to: 'user_accounts#new',        as: 'new_user_account'
  post 'users/:id/accounts/new',   to: 'user_accounts#create'

  #
  # Results
  #

  get 'results',            to: 'results#main_event'
  get 'no_events',          to: 'results#no_events'
  get 'events/:id/results', to: 'results#show', as: 'event_results'

  #
  # Events
  #

  get  'leagues', to: 'events#leagues'
  resources :events, only: [:index, :show] do
    get     :results, to: 'results#index'
    post    :join, on: :member
    delete  :quit, on: :member
  end

  #
  # Admin
  #

  namespace :admin do
    resources :events, only: [:index, :show, :edit, :update] do
      resources :tags, controller: 'event_tags', only: [:new, :create]

      resources :matches, controller: 'event_matches', only: [:index, :new, :create]
      # Note the singular on 'resource', this generates routes a different
      # set of routes, use rake routes for more info.
      resource :ruleset, controller: 'event_rulesets', only: [:edit, :update]
      resource :point_ruleset, controller: 'point_rulesets', only: [:edit, :update]
      # Shallow gives us a convenience path to create new tiers for an event
      # and list the tiers of an event, but short paths to edit, update and delete them
      resources :tiers, shallow: true, controller: 'event_tiers', only: [:show, :edit, :update] do
        resource :ruleset, controller: 'tier_rulesets', only: [:edit, :update]
        # Commented, until creation of division is implemented
        # resource :division, controller: 'event_divisions', only: [:new, :create]
      end
      resources :registrations, shallow: true, controller: 'event_registrations', only: [:index] do
        put :assign,  on: :collection
        put :deactivate, on: :member
      end
    end

    resources :matches, controller: 'event_matches', only: [:show, :edit, :update, :destroy] do
      post :validate_and_tag, on: :member
      post :auto_tag, on: :member
      resources :tags, controller: 'match_tags', only: [:new, :create]
    end

    resources :event_tags, only: [:edit, :update, :destroy]
    resources :match_tags, only: [:edit, :update, :destroy]

    # With this route and the one nested under tiers, we make a custom shallow resource
    resources :divisions, controller: 'event_divisions', only: [:edit, :update] do
      resource :ruleset, controller: 'division_rulesets', only: [:edit, :update]
    end

    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      resources :accounts, shallow: true, controller: 'user_accounts', except: [:index]
    end
  end

  mount Markitup::Rails::Engine, at: "markitup", as: "markitup"
  resources :pages
  resources :posts
  get '/',          to: 'pages#home'
  get ':permalink', to: 'pages#show'
  root to: "pages#home"

end
