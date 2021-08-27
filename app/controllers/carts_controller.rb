class CartsController < ApplicationController
  before_action :create_session_cart, :load_product, only: %i(add_to_cart)

  def add_to_cart
    id = params[:id]
    @carts.include?(id) ? add_exist_product(id) : add_new_product(id)
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

  def add_new_product id
    @carts[id] = handle_quantity
    redirect_to root_path
  end

  def add_exist_product id
    @carts[id] = @carts[id].to_i + handle_quantity
    redirect_to root_path
  end

  def handle_quantity
    params[:quantity].present? ? params[:quantity].to_i : 1
  end
end
