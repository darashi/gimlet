require 'yaml'

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
        @local_data[basename] = YAML.load_file(path)
      end
    end

    def data
      @local_data
    end
  end
end
