# frozen_string_literal: true

require 'json'

module Config
  DEFAULT_JSON_DATA_SUB_PATH = 'json_data/data.json'
  SAVE_TYPES = %w[json db].freeze

  @root_dir = File.dirname(__FILE__)
  @default_json_data_path = File.join(@root_dir, DEFAULT_JSON_DATA_SUB_PATH)
  @json_data_path = @default_json_data_path
  @json = {}

  class << self
    def json_data_path
      p = @json['json_data_path'] || @default_json_data_path
      return File.expand_path(p) if /^~/.match?(p)

      p = File.absolute_path(File.join(@root_dir, p)) unless File.absolute_path?(p)
      p
    end

    def read(conf_path)
      @json = to_json_from(conf_path)
    end

    def clear
      @json = {}
    end

    def save_type
      t = @json['save_type'] || SAVE_TYPES[0]
      raise StandardError '保存形式が正しくありません' unless SAVE_TYPES.find(t)

      t
    end

    private

    def to_json_from(path)
      str = ''
      File.open(path) do |f|
        str = f.read
      end
      # 空ファイルだとJSONパーサーがパースエラーを起こすので、{}を引数にする
      str = '{}' if str.empty?
      parser = JSON::Parser.new(str)
      parser.parse
    end
  end
end
