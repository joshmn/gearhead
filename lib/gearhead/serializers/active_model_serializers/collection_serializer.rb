module Gearhead
  module Serializers
    module ActiveModelSerializers
      class CollectionSerializer
        def self.for(records, serializer, options = {})
          options[:each_serializer] = serializer
          ::ActiveModelSerializers::SerializableResource.new(records, options)
        end
      end
    end
  end
end
