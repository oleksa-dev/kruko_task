# frozen_string_literal: true

module ApplicationHelper
  def money_formatter(sum)
    Money.from_cents(sum, "USD").format
  end
end
