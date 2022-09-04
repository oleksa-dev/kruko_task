# frozen_string_literal: true

class ResultsController < ApplicationController
  before_action :authenticate_user!

  def index
    @list = current_user.lists.find(list_params)
    @products = @list.products
    if @products.present?
      result = TotalCounterService.call(items: @products.pluck(:price))
      @total_price = result.total
    end

    respond_to do |format|
      if !@products.present? || result.success?
        format.html {render action: :index, status: 200 }
      elsif result.failure?
        format.html {render action: :index, alert: result.error, status: 500 }
      else
        format.html { render action: :index, alert: @item.errors.full_messages, status: 500 }
      end
    end
  end

  private

  def list_params
    params.require(:list_id)
  end
end
