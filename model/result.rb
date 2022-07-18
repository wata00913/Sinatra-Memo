class Result
  attr_reader :data, :msg

  class << self
    def success(data: nil, msg: nil, result: nil)
      new(success: true, data: data, msg: msg, result: result)
    end

    def fail(data: nil, msg: nil, result: nil)
      new(success: false, data: data, msg: msg, result: result)
    end
  end

  def success?
    @success
  end

  def [](attr)
    instance_variable_get "@#{attr}"
  end

  private

  def initialize(success:, data:, msg:, result:)
    @success = success
    @data = data
    @msg = msg
    @result = result
  end
end
