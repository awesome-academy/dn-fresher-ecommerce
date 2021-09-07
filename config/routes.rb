Rails.application.routes.draw do
  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  root to: "pages#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :carts, only: %i(index) do
    collection do
      get "add-to-cart/:id(/:quantity)", to: "carts#add_to_cart",
                                          as: :add_to
      get "minus-item-cart/:id(/:quantity)", to: "carts#minus_quantity_cart",
                                              as: :minus_item
      delete "delete-cart", to: "carts#delete_cart",
                                  as: :delete
      delete "delete-item-cart/:id", to: "carts#delete_item_cart",
                                      as: :destroy_item
    end
  end
  resources :products, only: :index
  resources :orders, only: %i(new create)
end
