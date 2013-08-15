require 'yaml'
require 'thor'
require 'forwardable'
require 'pathname'

module Gimlet
  class DataStore
    extend Forwardable

    class SourceNotFound < StandardError; end

    def initialize(source_path)
      @source_path = Pathname(source_path)
      @local_data = ::Gimlet::Util.recursively_enhance({})
      load_all!
    end

    def load_all!
      if @source_path.directory?
        load_from_directory!
      elsif @source_path.file?
        load_from_file!
      else
        raise SourceNotFound, 'No such file or directory - %s' % @source_path
      end
    end

    def load_from_directory!
      Pathname.glob(@source_path + '**/*.{yaml,yml}').each do |path|
        extension = path.extname
        basename = path.basename(extension)

        parts = path.relative_path_from(@source_path).split.map(&:to_s)[0..-1]
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

    def load_from_file!
      @local_data = ::Gimlet::Util.recursively_enhance(YAML.load_file(@source_path))
    end

    def_delegators :@local_data, :[], :method_missing, :to_h, :each
  end
end
