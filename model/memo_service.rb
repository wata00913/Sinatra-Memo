require_relative './memo'
require_relative './memo_json_repository'
require_relative './result'

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
    Result.success(result: 'success', msg: '登録に成功しました')
  end

  def find_by(id)
    memo = @repository.find_by(id)
    if memo
      Result.success(result: 'success', msg: '', data: memo)
    else
      Result.fail(result: 'fail', msg: '該当するメモは存在しません')
    end
  end

  def update(id, title, content)
    memo = Memo.new(id, title, content)

    begin
      @repository.update(memo)
      Result.success(result: 'success', msg: '変更に成功しました')
    rescue StandardError => e
      Result.fail(result: 'fail', msg: e.message)
    end
  end

  def delete(id)
    @repository.delete(id)
    Result.success(result: 'success', msg: '削除に成功しました')
  rescue StandardError => e
    Result.fail(result: 'fail', msg: e.message)
  end
end
