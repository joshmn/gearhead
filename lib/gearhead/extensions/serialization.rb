module Gearhead
  module Extensions
    module Serialization
      def self.included(klass)
        klass.define_gear_setting :serializer_adapter, Gearhead.config.serialization.adapter
      end

      def serializer_adapter(adapter)
        @_gear_serializer_adapter = adapter
      end

      def serializer(klass)
        @_gear_serializer = klass
      end

      def serializer_class
        real_serializer = Serializers::Lookup.for(:resource, @_gear_serializer_adapter)
        if real_serializer.respond_to?(:for)
          real_serializer.for(self)
        else
          real_serializer
        end
      end

      def collection_serializer
        Serializers::Lookup.for(:collection, @_gear_serializer_adapter)
      end
    end
  end
end
