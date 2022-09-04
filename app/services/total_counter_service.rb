# frozen_string_literal: true

class TotalCounterService < ApplicationService
  delegate :items, to: :context
  delegate :total, :error, to: :context

  def call
    total
  end

  private

  def total
    begin
      unless items.present?
        context.total = 0
        raise 'Empty items'
      end

      context.total = items.sum
    rescue => e
      error(e.message)
    end
  end
end
