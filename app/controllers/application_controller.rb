class ApplicationController < ActionController::Base
  include ApplicationHelper
  include CartsHelper
  include SessionsHelper

  before_action :set_locale
  before_action :load_product_in_cart, if: :session_cart_exist?

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def load_product_in_cart
    @products_load_in_cart = Product.load_by_ids session_cart.keys
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:error] = t :not_log_in
    redirect_to login_url
  end
end
