module Gearhead
  module Extensions
    module Attributes
      def self.included(klass)
        klass.define_gear_setting :custom_attributes, []
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

      def attribute(name, &block)
        @_gear_custom_attributes << [name, block]
      end
    end
  end
end
