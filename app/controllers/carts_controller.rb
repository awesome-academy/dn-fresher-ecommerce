class CartsController < ApplicationController
  before_action :load_product,
                only: %i(add_to_cart delete_item_cart minus_quantity_cart)
  before_action :sold_out?, :max_quantity, :session_cart, only: %i(add_to_cart)
  before_action :cart_include_product?,
                only: %i(delete_item_cart minus_quantity_cart)

  def index
    store_location
  end

  def add_to_cart
    id = params[:id]
    session_cart.include?(id) ? add_exist_product(id) : add_new_product(id)
  end

  def minus_quantity_cart
    id = params[:id]
    session_cart[id] = session_cart[id].to_i - handle_quantity
    return min_quantity_product_message id if quantity_less_than_one? id

    flash.now[:success] = t :minus_quantity_cart_success
    respond_to do |format|
      format.html{redirect_to carts_path}
      format.js
    end
  end

  def delete_item_cart
    session_cart.delete params[:id]
    return delete_cart if session_cart.count.zero?

    flash.now[:success] = t :delete_item_cart_success
    respond_to do |format|
      format.html{redirect_back_or root_path}
      format.js
    end
  end

  def delete_cart
    session[:cart] = nil
    flash[:success] = t :delete_cart_success
    redirect_to carts_path
  end

  private

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:warning] = t :not_found
    return render(js: "window.location = '#{carts_path}'") if request.xhr?

    redirect_back_or root_path
  end

  def sold_out?
    return unless @product.quantity.zero?

    flash[:warning] = t :sold_out
    redirect_back_or root_path
  end

  def max_quantity
    return if params[:quantity].to_i <= @product.quantity

    flash[:warning] = t :max_quantity
    redirect_back_or root_path
  end

  def add_new_product id
    session_cart[id] = handle_quantity
    return error_handle_add id if quantity_less_than_one? id

    successful_handle_add
  end

  def add_exist_product id
    session_cart[id] = session_cart[id].to_i + handle_quantity
    return error_handle_add id if quantity_less_than_one? id

    successful_handle_add
  end

  def handle_quantity
    params[:quantity].present? ? params[:quantity].to_i : 1
  end

  def successful_handle_add
    flash[:success] = t :add_to_cart_success
    redirect_back_or root_path
  end

  def error_handle_add id
    session_cart[id] = 1
    flash[:error] = t :add_to_cart_error
    redirect_back_or root_path
  end

  def cart_include_product?
    return if session_cart.include? params[:id]

    flash[:warning] = t :cart_not_contain_product
    return render(js: "window.location = '#{carts_path}'") if request.xhr?

    redirect_to carts_path
  end

  def quantity_less_than_one? id
    session_cart[id].to_i < 1
  end

  def min_quantity_product_message id
    session_cart[id] = 1
    flash.now[:warning] = t :min_quantity_product
    respond_to do |format|
      format.html{redirect_to carts_path}
      format.js
    end
  end
end
