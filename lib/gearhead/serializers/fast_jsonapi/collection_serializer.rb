module Gearhead
  module Serializers
    module FastJsonapi
      class CollectionSerializer
        def self.for(records, serializer, options = {})
          serializer.new(records, options)
        end
      end
    end
  end
end
