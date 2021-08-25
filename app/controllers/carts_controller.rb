class CartsController < ApplicationController
  before_action :create_session_cart, only: %i(add_to_cart)
  before_action :load_product, only: %i(add_to_cart)

  def add_to_cart
    @carts[params[:id]] = 1
    redirect_to root_path
  end

  private

  def create_session_cart
    session[:cart] ||= Hash.new
    @carts = session[:cart]
  end

  def load_product
    product = Product.find_by id: params[:id]
    return if product

    flash[:warning] = t :not_found
    redirect_to root_path
  end
end
