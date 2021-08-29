Rails.application.routes.draw do
    concern :paginatable do
      get "(page/:page)", action: :index, on: :collection, as: ""
    end

    root to: "pages#home"
    get "add-to-cart/:id(/:quantity)", to: "carts#add_to_cart",
                                       as: :add_to_cart
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
end
