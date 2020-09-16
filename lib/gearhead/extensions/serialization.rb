module Gearhead
  module Extensions
    module Serialization
      def self.included(klass)
        klass.define_gear_setting :attributes, []
        klass.define_gear_setting :custom_attributes, []
        klass.define_gear_setting :serializer_adapter, Gearhead.config.serialization.adapter
      end

      def _gear_attributes
        @_gear_attributes.presence || default_attributes
      end

      def attributes(*args)
        options = args.extract_options!
        @_gear_attributes = if options.blank?
                              args
                            else
                              if options[:only]
                                options[:only]
                              elsif options[:except]
                                default_attributes - options[:except]
                              end
                            end
      end

      def default_attributes
        @resource.columns_hash.keys.map(&:to_sym)
      end

      def attribute(name, &block)
        @_gear_custom_attributes << [name, block]
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
