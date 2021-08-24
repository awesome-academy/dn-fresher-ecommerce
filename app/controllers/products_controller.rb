class ProductsController < ApplicationController
  def index
    @categories = Category.order_name_asc
    @search = Product.lastest_product.ransack params[:q]
    @products = @search.result.page(params[:page]).per(params[:limit])
  end
end
