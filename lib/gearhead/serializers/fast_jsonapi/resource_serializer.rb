module Gearhead
  module Serializers
    module FastJsonapi
      class ResourceSerializer
        def self.for(page)
          klass = Class.new
          klass.include JSONAPI::Serializer
          klass.set_type page.resource.model_name.singular_route_key.to_param
          klass.attributes *(page._gear_attributes.presence || page.default_attributes)

          page._gear_custom_attributes.each do |attr, block|
            klass.attribute attr do |object|
              block.call(object)
            end
          end

          klass
        end
      end
    end
  end
end
