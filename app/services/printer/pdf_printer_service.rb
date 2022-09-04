# frozen_string_literal: true

module Printer
  class PdfPrinterService < ApplicationService
    delegate :title, :data, :total, to: :context
    delegate :pdf, :error, to: :context

    def call
      print
    end

    private

    def print
      begin
        raise 'No data' unless data.present?
        raise 'No total' unless total.present?

        pdf = config
        pdf[:locals] = {}
        pdf[:locals][:title] = title
        pdf[:locals][:data] = data
        pdf[:locals][:total] = total

        context.pdf = pdf
      rescue => e
        error(e.message)
      end
    end

    def config
      {
        pdf: 'pdf_document',
        template: 'pdfs/total',
        formats: [:html],
        layout: 'pdf',
        margin: { top: 2, bottom: 2, left: 2, right: 2 }
      }
    end
  end
end
