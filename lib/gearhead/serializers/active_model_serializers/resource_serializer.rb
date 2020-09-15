module Gearhead
  module Serializers
    module ActiveModelSerializers
      class ResourceSerializer
        def self.for(page)
          if defined?(ActiveModel::Serializer)
            klass = Class.new(ActiveModel::Serializer)
            klass.attributes *(page._gear_attributes.presence || page.default_attributes)

            page._gear_custom_attributes.each do |attr, block|
              klass.attribute attr do |klass|
                block.call(klass.object)
              end
            end

            klass
          end
        end
      end
    end
  end
end
