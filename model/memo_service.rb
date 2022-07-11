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

  def find_by(id)
    @repository.find_by(id)
  end

  def update(id, title, content)
    memo = Memo.new(id, title, content)
    @repository.update(memo)
    { result: 'success',
      msg: '変更に成功しました' }
  end

  def delete(id)
    @repository.delete(id)
    { result: 'success',
      msg: '削除に成功しました' }
  end
end
