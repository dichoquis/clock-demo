Rails.application.routes.draw do

  scope '(:locale)', locale: /es|en/ do
    resources :time_sheets

    post '/time_sheet/log', to: 'time_sheets#log'
    get '/time_sheet/note/:id', to: 'time_sheets#view_note', as: :time_sheet_note
    get '/time_sheet/note/:id/edit', to: 'time_sheets#edit_note', as: :edit_time_sheet_note
    patch '/time_sheet/note/:id', to: 'time_sheets#update_note', as: :update_time_sheet_note
  end

  scope '(:locale)', locale: /es|en/ do
    resources :users
    get '/users/:id/active', to: 'users#active'
    get '/users/:id/archive', to: 'users#archive'
  end

  scope '(:locale)', locale: /es|en/ do
    resources :tasks
  end

  scope "(:locale)", locale: /es|en/ do

    root 'home#index'

    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    get '/logout', to: 'sessions#destroy'
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
