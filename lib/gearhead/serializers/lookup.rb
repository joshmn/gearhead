module Gearhead
  module Serializers
    class Lookup
      def self.for(type, adapter_name = ::Gearhead.config.serialization.adapter)
        new(type, adapter_name).serializer
      end

      attr_reader :adapter_name
      def initialize(type, adapter_name)
        @type = type.to_s
        @adapter_name = adapter_name
      end

      def serializer
        "::Gearhead::Serializers::#{adapter}::#{@type.classify}Serializer".constantize
      end

      private

      def adapter
        adapter_name.to_s.camelcase
      end
    end
  end
end
