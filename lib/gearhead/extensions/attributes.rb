module Gearhead
  module Extensions
    module Attributes
      def self.included(klass)
      end

      def _gear_attributes
        @_gear_attributes
      end

      def attributes(*attrs)
        @_gear_attributes = *attrs
      end

      def default_attributes
        @resource.columns_hash.keys.map(&:to_sym)
      end
    end
  end
end
