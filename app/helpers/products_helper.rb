module ProductsHelper
  def products_showing limit = Settings.show_limit.show_6,
    page = Settings.minnimun_show
    return 1 if page == 1 || page.nil?

    limit.to_i * (page.to_i - 1) + 1
  end
end
