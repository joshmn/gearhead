module Gearhead
  module Serializers
    module ActiveModelSerializers
      class CollectionSerializer
        def self.for(records, serializer, options = {})
          serializer.new(records, options)
        end
      end
    end
  end
end
