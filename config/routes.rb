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
      get 'merchants/:id/customers_with_pending_invoices', to: 'merchants#customers_with_pending_invoices'

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

      get 'items/most_revenue', to: 'items#most_revenue'
      get 'items/most_items', to: 'items#most_items'
      get 'items/:id/best_day', to: 'items#best_day'
      basic_routes("items")
      resources :items, except: [:new, :edit, :update, :create], defaults: {format: 'json'} do
        get '/invoice_items', to: 'items#invoice_items'
        get '/merchant', to: 'items#merchant'
      end


      basic_routes("transactions")
      resources :transactions, except: [:new, :edit, :update, :create], defaults: {format: 'json'} do
        get '/invoice', to: 'transactions#invoice'
      end


      get 'customers/:id/favorite_merchant', to: 'customers#favorite_merchant'
      basic_routes("customers")
      resources :customers, except: [:new, :edit, :update, :create], defaults: {format: 'json'} do
        get '/invoices', to: 'customers#invoices'
        get '/transactions', to: 'customers#transactions'
      end

    end
  end

end
