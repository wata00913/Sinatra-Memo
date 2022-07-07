require 'json'
require_relative './memo_base_repository'
require_relative './memo'

class MemoJSONRepository < MemoBaseRepository
  def initialize(path)
    str = ''
    File.open(path) do |f|
      str = f.read
    end
    parser = JSON::Parser.new(str)
    json = parser.parse
    @memos = to_memos(json)
  end

  def find_by(id)
    @memos.find { |memo| memo.id == id }
  end

  private

  def to_memos(json)
    json.map do |j|
      Memo.new(j['id'], j['title'], j['content'])
    end
  end
end
