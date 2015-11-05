def basic_routes(type)
  get "/#{type}/find", to: "#{type}#find", defaults: {format: 'json'}
  get "/#{type}/find_all", to: "#{type}#find_all", defaults: {format: 'json'}
  get "/#{type}/random", to: "#{type}#random", defaults: {format: 'json'}
end

Rails.application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get 'merchants/most_revenue', to: 'merchants#most_revenue'
      get 'merchants/most_items', to: 'merchants#most_items'
      get 'merchants/revenue', to: 'merchants#revenue'
      get 'merchants/:id/revenue', to: 'merchants#merchant_revenue'
      get 'merchants/:id/favorite_customer', to: 'merchants#favorite_customer'
      basic_routes("merchants")
      resources :merchants, except: [:new, :edit, :update, :create] do
        get '/items', to: 'merchants#items'
        get '/invoices', to: 'merchants#invoices'
      end

      basic_routes("invoices")
      resources :invoices, except: [:new, :edit, :update, :create], defaults: {format: 'json'} do
        get '/transactions', to: 'invoices#transactions'
        get '/invoice_items', to: 'invoices#invoice_items'
        get '/items', to: 'invoices#items'
        get '/customer', to: 'invoices#customer'
        get '/merchant', to: 'invoices#merchant'
      end

      basic_routes("invoice_items")
      resources :invoice_items, except: [:new, :edit, :update, :create], defaults: {format: 'json'} do
        get '/invoice', to: 'invoice_items#invoice'
        get '/item', to: 'invoice_items#item'
      end

      basic_routes("items")
      resources :items, except: [:new, :edit, :update, :create], defaults: {format: 'json'} do
        get '/invoice_items', to: 'items#invoice_items'
        get '/merchant', to: 'items#merchant'
      end


      basic_routes("transactions")
      resources :transactions, except: [:new, :edit, :update, :create], defaults: {format: 'json'} do
        get '/invoice', to: 'transactions#invoice'
      end


      basic_routes("customers")
      resources :customers, except: [:new, :edit, :update, :create], defaults: {format: 'json'} do
        get '/invoices', to: 'customers#invoices'
        get '/transactions', to: 'customers#transactions'
      end

    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
