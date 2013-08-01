require 'yaml'
require 'thor'
require 'forwardable'
require 'pathname'

module Gimlet
  class DataStore
    extend Forwardable

    def initialize(data_directory)
      @data_directory = Pathname(data_directory)
      @local_data = ::Gimlet::Util.recursively_enhance({})
      load_all!
    end

    def load_all!
      Pathname.glob(@data_directory + '**/*.{yaml,yml}').each do |path|
        extension = path.extname
        basename = path.basename(extension)

        parts = path.relative_path_from(@data_directory).split.map(&:to_s)[0..-1]
        parts.delete('.')
        parts.pop

        current = @local_data
        parts.each do |part|
          current[part] ||= ::Gimlet::Util.recursively_enhance({})
          current = current[part]
        end

        current[basename.to_s] = ::Gimlet::Util.recursively_enhance(YAML.load_file(path))
      end
    end

    def_delegators :@local_data, :[], :method_missing, :to_h, :each
  end
end
