require 'minitest/autorun'
require_relative '../../model/memo_json_repository'

class MemoJSONRepositoryTest < Minitest::Test
  def setup
    @temp_data_path = 'temp.json'
  end

  def test_find_by_id
    expected_id = 'e6eeaa77-d547-4920-a3d2-634ab636c82b'
    expected_title = 'タイトル'
    expected_content = "テストだよ\n"
    json_str = <<~"TEXT"
      [
        {
          "id": "#{expected_id}",
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

    FileUtils.touch(@temp_data_path)
    File.open(@temp_data_path, 'w') do |f|
      f.puts(json_str)
    end

    memo_repository = MemoJSONRepository.new(@temp_data_path)
    memo = memo_repository.find_by(expected_id)


    assert_equal expected_id, memo.id
    assert_equal expected_title, memo.title
    assert_equal expected_content, memo.content
  end

  def teardown
    FileUtils.remove(@temp_data_path)
  end
end
