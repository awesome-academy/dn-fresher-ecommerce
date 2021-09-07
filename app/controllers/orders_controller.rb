class OrdersController < ApplicationController
  before_action :logged_in_user, :cart_exist?, only: %i(new create)
  before_action :load_delivery_address, only: %i(create)

  def new
    @order = Order.new
    @delivery_addresses = current_user.delivery_addresses
  end

  def create
    ActiveRecord::Base.transaction do
      @order = current_user.orders.build order_params
      build_cart_detail session_cart.keys.sort
      @order.save!
      session[:cart] = nil
    end
    flash[:success] = t :order_success
    redirect_to root_path
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = t :order_success
    render :new
  end

  private

  def order_params
    params.require(:order).permit :delivery_address_id
  end

  def load_delivery_address
    id = params[:order][:delivery_address_id]
    @delivery_address = DeliveryAddress.find_by id: id
    return if @delivery_address

    flash.now[:warning] = t :not_found_address
    render :new
  end

  def build_cart_detail ids
    ids.each_with_index do |product, index|
      item = {product_id: product,
              quantity: session_cart[product.to_s],
              price: @products_load_in_cart[index].price}
      @order.order_details.build item
      @products_load_in_cart[index].handle_update_quantity(
        session_cart[product.to_s]
      )
    end
  end

  def cart_exist?
    return if session_cart_exist?

    flash[:warning] = t :cart_empty
    redirect_to carts_path
  end
end
