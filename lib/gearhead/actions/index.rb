module Gearhead
  module Actions
    class Index
      delegate_missing_to :@request

      def self.build(gear, request)
        new(gear, request).build
      end

      attr_reader :scope, :gear, :request
      def initialize(gear, request)
        @gear = gear
        @request = request
        @collection = find_collection
        @serializer_options = {}
      end

      def build
        @collection = apply_includes
        @collection = apply_scope
        @collection = apply_query
        @collection = apply_pagination
        @collection = apply_serializer
        @collection
      end

      private

      def find_collection
        @gear.resource.all
      end

      def apply_includes
        return @collection if @gear._gear_includes.nil?
        @collection.includes(@gear._gear_includes)
      end

      def apply_scope
        return @collection unless valid_scope?(scope)
        if query = @gear._gear_defined_scopes[scope.to_sym].presence
          query.call(@collection)
        else
          @collection.send(scope)
        end
      end

      def scope
        params[:scope].presence || @gear._gear_default_scope
      end

      def valid_scope?(scope)
        return false if scope.nil?
        @gear._gear_defined_scopes.key?(scope.to_sym)
      end

      def apply_query
        return @collection unless params[:q].present?

        @collection.ransack(params[:q]).result
      end

      def apply_pagination
        return @collection unless @gear.paginate?

        paginator = ::Gearhead::Paginators::Paginator.paginate(@collection, self).call
        @collection = paginator.collection
        @serialization_options = paginator.serialization_options

        @collection
      end

      def apply_serializer
        @gear.serializer_class.new(@collection, serialization_options)
      end

      def serialization_options
        {
            links: {
                first: @serialization_options[:first_url],
                last: @serialization_options[:last_url],
                prev: @serialization_options[:prev_url],
                next: @serialization_options[:next_url]
            }
        }
      end
    end
  end
end
