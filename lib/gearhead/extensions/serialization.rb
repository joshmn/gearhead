module Gearhead
  module Extensions
    module Serialization
      def self.included(klass)
      end

      def serializer(klass)
        @_gear_serializer = klass
      end

      def serializer_class
        real_serializer = Serializers::Lookup.for(:resource)
        if real_serializer.respond_to?(:for)
          real_serializer.for(self)
        else
          real_serializer
        end
      end
    end
  end
end
