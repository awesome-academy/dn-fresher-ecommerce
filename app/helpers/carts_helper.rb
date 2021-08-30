module CartsHelper
  def session_cart
    session[:cart] ||= Hash.new
  end

  def session_cart_exist?
    session_cart.nil?
  end

  def total_quantity_cart cart
    session_cart_exist? ? 0 : cart.count
  end

  def total_price_cart cart
    return 0 if session_cart_exist?

    cart.reduce(0) do |total, product|
      total + product.price.to_i * session_cart[product.id.to_s].to_i
    end
  end
end
