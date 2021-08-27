Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    concern :paginatable do
      get "(page/:page)", action: :index, on: :collection, as: ""
    end

    root to: "pages#home"
    get "add-to-cart/:id(/:quantity)", to: "carts#add_to_cart",
                                       as: :add_to_cart
  end
end
