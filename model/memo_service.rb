# frozen_string_literal: true

require_relative '../config'
require_relative './memo'
require_relative './memo_json_repository'
require_relative './result'

CONF_FILE_NAME = 'config.json'.freeze
CONF_PATH = File.expand_path(CONF_FILE_NAME).freeze

class MemoService
  def initialize
    Config.read(CONF_PATH)
    @repository = MemoJSONRepository.new(Config.json_data_path)
  end

  def memos
    @repository.memos
  end

  def create(title, content)
    new_memo = Memo.new(nil, title, content)
    @repository.register(new_memo)
    Result.success(msg: '登録に成功しました')
  end

  def find_by(id)
    memo = @repository.find_by(id)
    if memo
      Result.success(msg: '', data: memo)
    else
      Result.fail(msg: '該当するメモは存在しません')
    end
  end

  def update(id, title, content)
    memo = Memo.new(id, title, content)

    begin
      @repository.update(memo)
      Result.success(msg: '変更に成功しました')
    rescue StandardError => e
      Result.fail(msg: e.message)
    end
  end

  def delete(id)
    @repository.delete(id)
    Result.success(msg: '削除に成功しました')
  rescue StandardError => e
    Result.fail(msg: e.message)
  end
end
