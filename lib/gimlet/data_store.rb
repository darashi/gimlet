require 'yaml'
require 'thor'
require 'forwardable'
require 'pathname'

module Gimlet
  class DataStore
    extend Forwardable

    def initialize(source_path)
      @source_path = Pathname(source_path)
      @local_data = ::Gimlet::Util.recursively_enhance({})
      load_all!
    end

    def load_all!
      if File.directory?(@source_path)
        load_from_directory!
      else
        load_from_file!
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
      %w(yaml yml).each do |ext|
        path = @source_path.sub_ext(".#{ext}")

        if path.exist?
          @local_data = ::Gimlet::Util.recursively_enhance(YAML.load_file(path))
          break
        end
      end
    end

    def_delegators :@local_data, :[], :method_missing, :to_h, :each
  end
end
