class ApplicationController < ActionController::Base
  include CartsHelper

  before_action :set_locale
  before_action :load_cart, unless: :session_cart_exist?

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def load_cart
    @carts = Product.load_by_ids current_cart.keys
  end
end
