module Gearhead
  module Paginators
    class WillPaginatePaginator < Paginator
      def paginate
        @collection = @records.paginate(page: page, per_page: per_page)
      end

      def serialization_options
        abort
      end
    end
  end
end
