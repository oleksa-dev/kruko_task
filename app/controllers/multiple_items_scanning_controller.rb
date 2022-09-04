# frozen_string_literal: true

class MultipleItemsScanningController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: :create

  def create
    barcodes = ::Csv::ReaderService.call(file: @create_params[:file])
    return redirect_to list_path(id: @list.id), alert: barcodes.message if barcodes.failure?

    result = ::Scanner::MultipleBarcodesScanningService.call(barcodes: barcodes.collection, scope: Product)

    return redirect_to list_path(id: @list.id), alert: result.message if result.failure?

    begin
      @list.items.transaction do
        @items = @list.items.create!(items_prepare(@create_params[:list_id], result.products))
      end
    rescue ActiveRecord::RecordInvalid => e
      return redirect_to list_path(id: @list.id), alert: e.message
    ensure
      if result.success? && !result.has_error
        return redirect_to list_path(id: @list.id), notice: 'Products were successfully added'
      elsif result.success? && result.has_error
        return redirect_to list_path(id: @list.id), alert: result.message
      else
        return redirect_to list_path(id: @list.id), alert: @item.errors.full_messages
      end
    end
  end

  private

  def set_list
    @list ||= current_user.lists.find(create_params[:list_id])
  end

  def create_params
    @create_params ||= params.permit(:list_id, :file)
  end

  def items_prepare(list_id, products_ids)
    products_ids.map {|product| {list_id: list_id, product_id: product}}
  end
end
