require 'minitest/autorun'
require_relative '../config'

class ConfigTest < Minitest::Test
  def setup
    @config_path = File.join(File.expand_path(__dir__), 'config.json')
    @setting_json_data_path = File.join(File.expand_path(__dir__), 'data.json')
    @default_json_data_path = File.join(File.expand_path('..'), 'data.json')
    @save_type = 'json'

    File.open(@config_path, 'w') do |f|
      data = <<~TEXT
        {
            "json_data_path": "./test/data.json",
            "save_type": "json"
        }
      TEXT
      f.puts data
    end
  end

  def teardown
    Config.clear
    FileUtils.rm(@config_path) if File.exist?(@config_path)
  end

  def test_default_json_data_path
    assert_equal @default_json_data_path, Config.json_data_path
  end

  def test_setting_json_data_path
    Config.read(@config_path)
    assert_equal @setting_json_data_path, Config.json_data_path
  end

  def test_default_save_type_is_json
    assert_equal @save_type, Config.save_type
  end

  def test_default_save_type_is_json
    Config.read(@config_path)
    assert_equal @save_type, Config.save_type
  end
end
