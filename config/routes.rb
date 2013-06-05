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
  # Users (Public)
  #

  # TODO: Move admin routes and, cleanup public routes
  get 'profile',        to: 'users#profile'
  resources :users do
    get  :profile,      on: :member
    post :toggle_admin, on: :member
    resources :accounts
  end

  #
  # Results
  #

  get 'results',        to: 'results#main_event'
  get 'no_events',      to: 'results#no_events'

  #
  # Events (Public)
  #

  get  'leagues', to: 'events#leagues'
  post 'registrations/:registration_id/matches/download',  to: "matches#download", as: "download_registration_matches"
  post 'events/:id/accounts/:account_id/join_other',  to: 'events#join_other', as: 'join_other'
  delete 'events/:id/registrations/:registration_id/quit', to: 'events#quit', as: 'event_registration_quit'
  resources :events, only: [:index, :show] do
    get     :results, to: 'results#index'
    member do
      post    :join
      delete  :quit
    end
  end

  #
  # Matches
  #

  # TODO: Move whole matches controller to Admin, where it makes sense.
  post  'matches/:id/validate',   to: "matches#validate",   as: "validate_match"
  post  'matches/:id/check_tags', to: "matches#check_tags", as: "check_match_tags"

  #
  # Admin
  #

  namespace :admin do
    resources :events, only: [:index, :show, :edit, :update] do
      resources :tags, shallow: true, controller: 'event_tags', except: [:index]
      # Note the singular on 'resource', this generates routes a different
      # set of routes, use rake routes for more info.
      resource :ruleset, controller: 'event_rulesets', only: [:edit, :update]
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
    # With this route and the one nested under tiers, we make a custom shallow resource
    resources :divisions, controller: 'event_divisions', only: [:edit, :update] do
      resource :ruleset, controller: 'division_rulesets', only: [:edit, :update]
    end
    resources :users, only: [:index, :show, :edit, :update] do
      resources :accounts, shallow: true, controller: 'user_accounts', except: [:index]
    end
  end


  mount Markitup::Rails::Engine, at: "markitup", as: "markitup"
  resources :pages
  resources :posts
  get '/',          to: 'pages#home'
  get ':permalink', to: 'pages#show'
  root to: "pages#home"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
