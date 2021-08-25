module CartsHelper
  def current_cart
    @current_cart ||= session[:cart]
  end

  def session_cart_exist?
    current_cart.nil?
  end

  def total_quantity_cart cart
    session_cart_exist? ? 0 : cart.count
  end

  def total_price_cart cart
    return 0 if session_cart_exist?

    cart.reduce(0) do |total, product|
      total + product.price.to_i * current_cart[product.id.to_s].to_i
    end
  end
end
