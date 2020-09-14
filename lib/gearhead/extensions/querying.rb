module Gearhead
  module Extensions
    module Querying
      def self.included(klass)
        klass.define_gear_setting :includes, {}
      end

      def includes(*keys)
        @_gear_includes = *keys
      end
    end
  end
end
