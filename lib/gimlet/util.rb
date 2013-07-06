module Gimlet
  class Util
    class << self
      def wrap_hash(hash)
        Thor::CoreExt::HashWithIndifferentAccess.new(hash)
      end
    end
  end
end
