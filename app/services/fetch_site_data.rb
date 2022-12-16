# frozen_string_literal: true

require 'nokogiri'

# Service to crawl site
class FetchSiteData < Kimurai::Base
  BASE_URL = Rails.application.credentials[:site_url]
  @name = 'fetch_site_data'
  @engine = :mechanize
  @config = {
    user_agent: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36',
    before_request: { delay: 1..2 }
  }

  def self.process(sku)
    @start_urls = [BASE_URL + sku]
    crawl!
  end

  def parse(response, url:, data: {})
    product_data = parse_product_data(response)

    sku = URI.parse(url).query.split('=').last
    product = Product.find_or_initialize_by(sku: sku)
    product.assign_attributes(product_data)
    product.save
  end

  def parse_product_data(document)
    product_data = {}
    product_data[:name] = document.css('.pl-Heading--pageTitle')[0]&.text
    product_data[:price] = document.css('.StandardPriceBlock .BasePriceBlock')[0]&.text
    product_data[:image_urls] = fetch_images(document.css('.ProductDetailImageCarouselVariantB').first)

    product_data
  end

  def fetch_images(document)
    images = []
    if document
      images = document.css('.ThumbnailCarousel ul').first.css('li img')
                       .collect { |img| img.attribute('src').value }
    end
    images
  end
end
