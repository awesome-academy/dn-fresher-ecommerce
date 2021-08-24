module ApplicationHelper
  def toastr_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
      setting_button = "{closeButton: true, progressBar: true })"
      text = "toastr.#{type}('#{message}', '', " + setting_button
      flash_messages << text if message
    end.join("\n")
  end

  def full_title page_title = ""
    base_title = t "title_page"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end
end
