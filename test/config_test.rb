require 'minitest/autorun'
require_relative '../config'

class ConfigTest < Minitest::Test
  def setup
    @config_path = File.join(File.expand_path('..'), 'config.json')
    @setting_json_data_path = File.join(File.expand_path(__dir__), 'data.json')
    @default_json_data_path = File.join(File.expand_path('..'), 'data.json')
  end

  def test_default_and_setting_json_data_path
    assert_equal @default_json_data_path, Config.json_data_path
    Config.read(@config_path)
    assert_equal @setting_json_data_path, Config.json_data_path
  end
end
