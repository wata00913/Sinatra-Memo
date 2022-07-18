class Result
  attr_reader :data, :message

  class << self
    def success(data: nil, message: nil)
      new(success: true, data: data, message: message)
    end

    def fail(data: nil, message: nil)
      new(success: false, data: data, message: message)
    end
  end

  def success?
    @success
  end

  private

  def initialize(success:, data:, message:)
    @success = success
    @data = data
    @message = message
  end
end
