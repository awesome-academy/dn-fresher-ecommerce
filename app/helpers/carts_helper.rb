module CartsHelper
  def current_cart
    @current_cart ||= session[:cart]
  end

  def session_cart_exist?
    current_cart.nil?
  end

  def total_quantity_cart cart
    return 0 if session_cart_exist?

    cart.count
  end

  def total_price_cart cart
    return 0 if session_cart_exist?

    @total = 0
    cart.each do |product|
      @total += product.price * current_cart[product.id.to_s]
    end
    @total
  end
end
