# frozen_string_literal: true

# Products controller
class ProductsController < ApplicationController
  before_action :update_options, only: :create

  def index
    @products = Product.all
  end

  def new; end

  def create
    response = FetchSiteData.process(params[:sku])

    if response[:status] == :completed
      flash.notice = 'Data has been scraped successfully!'
    else
      flash.alert = 'Something went wrong with scraper'
    end

    respond_to do |format|
      format.html { redirect_to products_path }
    end
  end

  private

  def update_options
    product = Product.find_or_initialize_by(sku: params[:sku])
    selected_options = params.select { |_key, value| value == '1' }.keys
    is_new = true
    is_new = false if product.persisted?
    product.selected_options = selected_options
    product.save

    redirect_to products_path unless is_new
  end
end
