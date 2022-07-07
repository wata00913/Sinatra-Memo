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

  def teardown
    FileUtils.remove(@temp_data_path)
  end
end
