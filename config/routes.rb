Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "pages#home"
  end
end
