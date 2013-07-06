require 'yaml'
require 'thor'

module Gimlet
  class DataStore
    def initialize(data_directory)
      @data_directory = data_directory
      @local_data = {}
      load_all!
    end

    def load_all!
      Dir[File.join(@data_directory, '**', '*.yaml')].each do |path|
        extension = File.extname(path)
        basename = File.basename(path, extension)
        @local_data[basename] = ::Gimlet::Util.wrap_hash(YAML.load_file(path))
      end
    end

    def method_missing(path)
      if data = @local_data[path.to_s]
        return data
      end

      super
    end

    def to_h
      @local_data
    end
  end
end
