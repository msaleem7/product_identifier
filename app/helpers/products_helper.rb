# frozen_string_literal: true

# product helpers
module ProductsHelper
  def site_url
    Rails.application.credentials[:site_url]
  end

  def availble?(product, name)
    product.selected_options.include?(name)
  end

  def pretify_urls(urls)
    urls.join("<br/>")
  end
end
