require 'minitest/autorun'
require_relative '../../model/memo_json_repository'

class MemoJSONRepositoryTest < Minitest::Test
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

    memo_repository = MemoJSONRepository.new(json_str)
    memo = memo_repository.find_by(expected_id)

    assert_equal expected_id, memo.id
    assert_equal expected_title, memo.title
    assert_equal expected_content, memo.content
  end
end
