# frozen_string_literal: true

class PdfPrinterController < ApplicationController
  before_action :pdf_params, only: [:index]

  def index
    @list = current_user.lists.find(pdf_params)
    @products = @list.products
    if @products.present?
      total_price = TotalCounterService.call(items: @products.pluck(:price))
      @total_price = total_price.total
      result = Printer::PdfPrinterService.call(title: @list.name, data: @products, total: @total_price)
      pdf = result.pdf if result.success?
    end

    respond_to do |format|
      if @products.present? && result.success?
        format.pdf { render pdf }
      else
        format.html { redirect_to list_results_path(pdf_params), alert: result.failure? ? result.message : 'No products'}
      end
    end
  end

  private

  def pdf_params
    params.require(:list_id)
  end
end
