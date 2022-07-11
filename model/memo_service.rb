require_relative './memo'
require_relative './memo_json_repository'

class MemoService
  def initialize
    @save_type = 'json_file'
    @default_path = File.absolute_path('json_data/data.json')
    @repository = MemoJSONRepository.new(@default_path)
  end

  def memos
    @repository.memos
  end

  def create(title, content)
    new_memo = Memo.new(nil, title, content)
    @repository.register(new_memo)
    { result: 'success',
      msg: '登録に成功しました' }
  end
end
