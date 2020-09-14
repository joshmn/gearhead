module Gearhead
  module Serializers
    module ActiveModelSerializers
      class ResourceSerializer
        def self.for(page)
          if defined?(ActiveModelSerializers::Serializer)
            klass = Class.new(ActiveModelSerializers::Serializer)
            klass.attributes *(page._gear_attributes.presence || page.default_attributes)

            klass
          end
        end
      end
    end
  end
end
