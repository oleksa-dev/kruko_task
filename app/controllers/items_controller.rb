# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: :create

  def create
    result = ::Scanner::SingleBarcodeScanningService.call(barcode: @create_params[:barcode], scope: Product)
    return redirect_to list_path(@list), alert: result.message if result.failure?

    item = @list.items.new(list_id: @create_params[:list_id], product_id: result.product.id)

    respond_to do |format|
      if item.save
        format.html { redirect_to list_path(@list), notice: 'Product was successfully added' }
      else
        format.html { redirect_to list_path(@list), alert: @item.errors.full_messages }
      end
    end
  end

  private

  def set_list
    @list ||= current_user.lists.find(create_params[:list_id])
  end

  def create_params
    @create_params ||= params.permit(:list_id, :barcode)
  end
end
