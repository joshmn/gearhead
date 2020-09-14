module Gearhead
  module Serializers
    class Lookup
      def self.for(action)
        new(action).serializer
      end

      def initialize(action)
        @action = action.to_s
      end

      def serializer
        "::Gearhead::Serializers::#{adapter}::#{@action.classify}Serializer".constantize
      end

      private

      def adapter_name
        ::Gearhead.config.serialization.adapter
      end

      def adapter
        adapter_name.to_s.classify
      end
    end
  end
end
