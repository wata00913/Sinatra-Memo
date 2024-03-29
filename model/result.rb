# frozen_string_literal: true

class Result
  attr_reader :data, :msg

  class << self
    def success(data: nil, msg: nil)
      new(success: true, data: data, msg: msg)
    end

    def fail(data: nil, msg: nil)
      new(success: false, data: data, msg: msg)
    end
  end

  def success?
    @success
  end

  private

  def initialize(success:, data:, msg:)
    @success = success
    @data = data
    @msg = msg
  end
end
