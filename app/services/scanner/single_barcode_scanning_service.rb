# frozen_string_literal: true

module Scanner
  class SingleBarcodeScanningService < ApplicationService
    delegate :barcode, :scope, to: :context
    delegate :product, to: :context

    def call
      scan
    end

    private

    def scan
      begin
        raise 'Empty barcode' unless barcode.present?
        product = scope.find_by(barcode: barcode)
        raise ActiveRecord::RecordNotFound, 'Product not found' unless product.present?
        context.product = product
      rescue => e
        error(e.message)
      rescue ActiveRecord::RecordNotFound => e
        error(e.message)
      rescue ActiveRecord::ActiveRecordError => e
        error(e.message)
      end
    end
  end
end
