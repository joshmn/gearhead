module Gearhead
  module Paginators
    class Lookup
      def self.for(action)
        new(action).paginator
      end

      def initialize(action)
        @action = action.to_s
      end

      def paginator
        "::Gearhead::Paginators::#{adapter}Paginator".constantize
      end

      private

      def adapter_name
        ::Gearhead.config.pagination.adapter
      end

      def adapter
        adapter_name.to_s.classify
      end
    end
  end
end
