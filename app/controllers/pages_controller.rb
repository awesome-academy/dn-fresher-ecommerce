class PagesController < ApplicationController
  def home
    store_location
    @products = Product.all
  end
end
