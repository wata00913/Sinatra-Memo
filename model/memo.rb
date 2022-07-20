# frozen_string_literal: true

require 'securerandom'

class Memo
  attr_reader :id
  attr_accessor :title, :content

  def initialize(id = nil, title, content)
    @id = id || SecureRandom.uuid
    @title = title
    @content = content
  end
end
