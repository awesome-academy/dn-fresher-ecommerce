class CartsController < ApplicationController
  before_action :session_cart, :load_product,
                only: %i(add_to_cart remove_from_cart)
  before_action :cart_include_product?, only: %i(remove_from_cart)

  def add_to_cart
    id = params[:id]
    session_cart.include?(id) ? add_exist_product(id) : add_new_product(id)
  end

  def remove_from_cart
    session_cart.delete params[:id]
    flash[:success] = t :remove_item_success
    redirect_to root_path
  end

  private

  def load_product
    product = Product.find_by id: params[:id]
    return if product

    flash[:warning] = t :not_found
    redirect_to root_path
  end

  def add_new_product id
    session_cart[id] = handle_quantity
    flash[:success] = t :add_to_cart_success
    redirect_to root_path
  end

  def add_exist_product id
    session_cart[id] = session_cart[id].to_i + handle_quantity
    flash[:success] = t :add_to_cart_success
    redirect_to root_path
  end

  def handle_quantity
    params[:quantity].present? ? params[:quantity].to_i : 1
  end

  def cart_include_product?
    return if session_cart.include? params[:id]

    flash[:warning] = t :cart_not_contain_product
    redirect_to root_path
  end
end
