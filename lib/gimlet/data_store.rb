require 'yaml'
require 'thor'
require 'forwardable'

module Gimlet
  class DataStore
    extend Forwardable

    def initialize(data_directory)
      @data_directory = data_directory
      @local_data = ::Gimlet::Util.recursively_enhance({})
      load_all!
    end

    def load_all!
      Dir[File.join(@data_directory, '**', '*.yaml')].each do |path|
        extension = File.extname(path)
        basename = File.basename(path, extension)
        @local_data[basename] = ::Gimlet::Util.recursively_enhance(YAML.load_file(path))
      end
    end

    def_delegator :@local_data, :[]
    def_delegator :@local_data, :method_missing
    def_delegator :@local_data, :to_h
  end
end
