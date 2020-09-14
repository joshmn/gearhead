module Gearhead
  module Paginators
    class Paginator
      def self.paginate(records, action)
        ::Gearhead::Paginators::Lookup.for(action).new(records, action)
      end

      attr_reader :collection
      def initialize(records, action)
        @records = records
        @collection = nil
        @action = action
      end

      # should set @collection
      def paginate
        raise NotImplementedError, "define paginate and set @collection"
      end

      def call
        paginate
        self
      end

      def serialization_options
        {}
      end

      private

      def per_page
        gear._gear_per_page
      end

      def page
        request.params[:page] || 1
      end

      def gear
        @action.gear
      end

      def request
        @action.request
      end
    end
  end
end
