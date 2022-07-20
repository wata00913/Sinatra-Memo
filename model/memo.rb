# frozen_string_literal: true

require 'securerandom'

class Memo
  attr_reader :id
  attr_accessor :title, :content

  def initialize(_id = nil, title, content, id: nil)
    warn('Please use id argument of hash variable instead of _id argument', uplevel: 1) unless alternative_for_refactor?(_id, id)
    alternative_id = alternative_for_refactor?(_id, id) ? id : _id
    @id = alternative_id || SecureRandom.uuid
    @title = title
    @content = content
  end

  private

  def alternative_for_refactor?(old, new)
    # 下記組み合わせは、置き換え済みの場合
    # (old, new) = (nil, nil)
    # (old, new) = (string, string)
    # (old, new) = (nil, string)
    !(old && new.nil?)
  end
end
