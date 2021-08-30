module CartsHelper
  def session_cart
    session[:cart] ||= Hash.new
  end

  def current_cart
    @current_cart ||= session[:cart]
  end

  def session_cart_exist?
    current_cart.present?
  end

  def total_item_cart price, total_quantity_item
    @total_item_cart = price.to_i * total_quantity_item.to_i
  end

  def total_quantity_cart cart
    session_cart_exist? ? cart.count : 0
  end

  def total_price_cart cart
    return 0 unless session_cart_exist?

    cart.reduce(0) do |total, product|
      total + product.price.to_i * session_cart[product.id.to_s].to_i
    end
  end
end
