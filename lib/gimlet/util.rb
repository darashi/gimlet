module Gimlet
  class Util
    class << self
      def recursively_enhance(data)
        case data
        when Hash
          data = ::Thor::CoreExt::HashWithIndifferentAccess.new(data)
          data.each do |key, value|
            data[key] = recursively_enhance(value)
          end
          data
        when Array
          data.map do |value|
            recursively_enhance(value)
          end
        else
          data
        end
      end
    end
  end
end
