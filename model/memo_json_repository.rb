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
    @path = path
  end

  def find_by(id)
    @memos.find { |memo| memo.id == id }
  end

  def register(new_memo)
    raise '登録済みのメモがあるため登録できません。' if find_by(new_memo.id)

    @memos << new_memo
    write(to_json_str(@memos))
    true
  end

  def update(memo)
    raise '登録済みのメモがないため更新できません。' unless find_by(memo.id)

    idx = @memos.find_index { |m| memo.id == m.id }
    @memos[idx] = memo
    write(to_json_str(@memos))
    true
  end

  private

  def to_memos(json)
    json.map do |j|
      Memo.new(j['id'], j['title'], j['content'])
    end
  end

  def to_json_str(memos)
    h_list = memos.map do |m|
      { id: m.id, title: m.title, content: m.content }
    end
    JSON::State.new.generate(h_list)
  end

  def write(json_str)
    File.open(@path, 'w') do |f|
      f.puts json_str
    end
  end
end
