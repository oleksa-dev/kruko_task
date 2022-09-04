# frozen_string_literal: true

module Scanner
  class MultipleBarcodesScanningService < ApplicationService
    delegate :barcodes, :scope, to: :context
    delegate :products, :barcodes, :has_error, :message, to: :context

    def call
      scan
    end

    private

    def scan
      begin
        raise 'Empty barcode' unless barcodes.present?
        products = scope.select(:id, :barcode).where(barcode: barcodes)

        raise ActiveRecord::RecordNotFound, error_message(barcodes) unless products.present?

        founded_barcodes = products.pluck(:barcode)
        has_error = founded_barcodes != barcodes
        not_found_barcodes = barcodes - founded_barcodes

        context.products = products.pluck(:id)
        context.has_error = has_error
        context.message = error_message(not_found_barcodes) if has_error
      rescue Exception => e
        error(e.message, true)
      rescue ActiveRecord::RecordNotFound => e
        error(e.message, true)
      rescue ActiveRecord::ActiveRecordError => e
        error(e.message, true)
      end
    end

    def error_message(barcodes)
      "No roducts were found with barcodes: #{barcodes.join(', ')}"
    end
  end
end
