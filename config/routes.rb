Rails.application.routes.draw do
  resources :settings
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  devise_scope :user do
    authenticated :user do
      root :to => 'static_pages#home', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'static_pages#login', as: :unauthenticated_root

    end
  end
  scope '/admin' do
    resources :users
  end
    get 'static_pages/signup'
    get 'static_pages/forgot_password'
  resources :remission_guides do
    collection do
      get 'search_sales_order_details' => 'remission_guides#search_sales_order_details', as: :search_sales_order_details
    end
  end

  

  resources :vehicles

  resources :drivers

  resources :sales_orders

  resources :contracts do
    resources :addendums do
      member do
        put 'update_credit' => 'addendums#update_credit', as: :update_credit
      end
    end
  end

  resources :clients

  resources :purchase_orders do
    collection do
      get ":id/print_document" => 'purchase_orders#print_document', as: :print_document
    end
  end

  resources :suppliers

  resources :businesses

  resources :product_lots do
    collection do
      get 'lot_by_product/:product_id' => 'product_lots#lot_by_product', as: :lot_by_product
      get 'empty_lots/:product_id' => 'product_lots#empty_lots', as: :empty_lots
      get 'search_lots_by_product_front' => 'product_lots#search_lots_by_product_front', as: :search_lots_by_product_front
      get 'search_lots_by_product'
      get 'search_lots_close_to_expire_front' => 'product_lots#search_lots_close_to_expire_front', as: :search_lots_close_to_expire_front
      get 'search_lots_close_to_expire'
    end
  end

  resources :products

  resources :categories

  
  

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
