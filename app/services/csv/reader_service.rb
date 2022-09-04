# frozen_string_literal: true

module Csv
  class ReaderService < ApplicationService
    require 'csv'

    CSV = 'text/csv'

    delegate :file, to: :context
    delegate :collection, :message, to: :context

    def call
      read
    end

    private

    def read
      begin
        unless file.content_type.eql?(CSV)
          raise TypeError,'Wrtong file type. Works only with CSV files'
        end

        collection = File.read(file).strip.split(';')

        raise 'Empty file' unless collection.present?
        context.collection = collection
      rescue => e
        error(e.message)
      rescue TypeError => e
        error(e.message)
      rescue  Errno::ENOENT => e
        error(e.message)
      end
    end
  end
end
