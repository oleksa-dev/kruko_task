# frozen_string_literal: true

class ApplicationService
  include Interactor

  def call
    raise NotImplementedError, 'You should implement this method in a child class.'
  end

  private

  def error(msg, error=nil)
    payload = {}
    payload[:message] = msg
    payload[:error] = error unless error.nil?
    context.fail!(payload)
  end
end
