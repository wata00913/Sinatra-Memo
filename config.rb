require 'json'

module Config
  DEFAULT_JSON_DATA_FILE_NAME = 'data.json'.freeze
  @root_dir = File.dirname(__FILE__)
  @default_json_data_path = File.join(@root_dir, DEFAULT_JSON_DATA_FILE_NAME)
  @json_data_path = @default_json_data_path
  @json = {}

  class << self
    def json_data_path
      p = @json['json_data_path'] || @default_json_data_path
      p = File.expand_path(File.join(@root_dir, p)) unless File.absolute_path?(p)
      p
    end

    def read(conf_path)
      @json = to_json_from(conf_path)
    end

    def clear
      @json = {}
    end

    private

    def to_json_from(path)
      str = ''
      File.open(path) do |f|
        str = f.read
      end
      parser = JSON::Parser.new(str)
      parser.parse
    end
  end
end
