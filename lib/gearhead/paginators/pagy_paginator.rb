require 'pagy/extras/metadata'

module Gearhead
  module Paginators
    class PagyPaginator < Paginator
      include Pagy::Backend

      def paginate
        @pagy, @collection = pagy(@records, items: per_page, page: page)
      end

      def serialization_options
        pagy_metadata(@pagy)
      end
    end
  end
end
