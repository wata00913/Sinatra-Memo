# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../config'

class ConfigTest < Minitest::Test
  def setup
    @config_path = File.join(File.expand_path(__dir__), 'config.json')
    @setting_json_data_path = File.join(File.expand_path(__dir__), 'data.json')
    @default_json_data_path = File.join(File.expand_path('..'), 'data.json')
    @save_type = 'json'
  end

  def create_test_data_file(path)
    File.open(path, 'w') do |f|
      data = <<~TEXT
        {
            "json_data_path": "./test/data.json",
            "save_type": "json"
        }
      TEXT
      f.puts data
    end
  end

  def create_test_empty_data_file(path)
    File.open(path, 'w')
  end

  def teardown
    Config.clear
    FileUtils.rm(@config_path) if File.exist?(@config_path)
  end

  def test_default
    assert_equal @default_json_data_path, Config.json_data_path
    assert_equal @save_type, Config.save_type
  end

  def test_setting_without_data
    create_test_empty_data_file(@config_path)
    Config.read(@config_path)
    assert_equal @default_json_data_path, Config.json_data_path
    assert_equal @save_type, Config.save_type
  end

  def test_setting
    create_test_data_file(@config_path)
    Config.read(@config_path)
    assert_equal @setting_json_data_path, Config.json_data_path
    assert_equal @save_type, Config.save_type
  end
end
