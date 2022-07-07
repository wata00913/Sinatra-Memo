require 'minitest/autorun'
require_relative '../../model/memo_json_repository'

class MemoJSONRepositoryTest < Minitest::Test
  def setup
    @temp_data_path = 'temp.json'
  end

  def create_test_data_file(path, str)
    FileUtils.touch(path)
    File.open(path, 'w') do |f|
      f.puts(str)
    end
  end

  def test_find_by_id
    expected = { id: 'e6eeaa77-d547-4920-a3d2-634ab636c82b', title: 'タイトル', content: "テストだよ\n" }
    json_str = <<~"TEXT"
      [
        {
          "id": "#{expected[:id]}",
          "title": "タイトル",
          "content": "テストだよ\\n"
        },
        {
          "id": "8bd1f78b-a362-4e8d-8510-c3016be1fa89",
          "title": "タイトル2",
          "content": "hoge"
        }
      ]
    TEXT

    create_test_data_file(@temp_data_path, json_str)

    memo_repository = MemoJSONRepository.new(@temp_data_path)
    memo = memo_repository.find_by(expected[:id])

    assert_equal expected[:id], memo.id
    assert_equal expected[:title], memo.title
    assert_equal expected[:content], memo.content
  end

  def test_register_new_memo
    # データ件数が0件の場合のファイルを作成
    create_test_data_file(@temp_data_path, '[]')

    new_memo = Memo.new(nil, '新規メモ', "メモ作成\n")
    memo_repository_before_reload = MemoJSONRepository.new(@temp_data_path)
    assert memo_repository_before_reload.register(new_memo)

    registered_memo_before_reload = memo_repository_before_reload.find_by(new_memo.id)
    assert_equal new_memo.id, registered_memo_before_reload.id
    assert_equal new_memo.title, registered_memo_before_reload.title
    assert_equal new_memo.content, registered_memo_before_reload.content

    # 登録後のJSONファイルを再読み込んで登録できたか確認
    memo_repository_after_reload = MemoJSONRepository.new(@temp_data_path)
    registered_memo_after_reload = memo_repository_after_reload.find_by(new_memo.id)
    assert_equal new_memo.id, registered_memo_after_reload.id
    assert_equal new_memo.title, registered_memo_after_reload.title
    assert_equal new_memo.content, registered_memo_after_reload.content
  end

  def test_update_memo
    expected = { id: 'e6eeaa77-d547-4920-a3d2-634ab636c82b', title: 'タイトル変更', content: "内容を変更したよ\n" }
    json_str = <<~"TEXT"
      [
        {
          "id": "8bd1f78b-a362-4e8d-8510-c3016be1fa89",
          "title": "タイトル2",
          "content": "hoge"
        },
        {
          "id": "#{expected[:id]}",
          "title": "タイトル",
          "content": "テストだよ\\n"
        }
      ]
    TEXT
    create_test_data_file(@temp_data_path, json_str)
    
    memo_repository_before_reload = MemoJSONRepository.new(@temp_data_path)
    memo = Memo.new(expected[:id], expected[:title], expected[:content])

    memo_repository_before_reload.update(memo)
    updated_memo = memo_repository_before_reload.find_by(expected[:id])
    assert_equal expected[:id], updated_memo.id
    assert_equal expected[:title], updated_memo.title
    assert_equal expected[:content], updated_memo.content

    memo_repository_after_reload = MemoJSONRepository.new(@temp_data_path)
    updated_memo_after_reload = memo_repository_before_reload.find_by(expected[:id])
    assert_equal expected[:id], updated_memo_after_reload.id
    assert_equal expected[:title], updated_memo_after_reload.title
    assert_equal expected[:content], updated_memo_after_reload.content
  end

  def teardown
    FileUtils.remove(@temp_data_path) if File.exist?(@temp_data_path)
  end
end
