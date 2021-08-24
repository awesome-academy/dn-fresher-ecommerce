class PagesController < ApplicationController
  def home
    store_location
    @products = Product.lastest_9_product
  end
end
