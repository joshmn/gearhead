module Gearhead
  module Extensions
    module Pagination
      def self.included(klass)
        klass.define_gear_setting :paginate, Gearhead.config.pagination.enabled?
        klass.define_gear_setting :per_page, Gearhead.config.pagination.per_page
      end

      def paginate?
        @_gear_paginate === true
      end

      def paginate(val)
        @_gear_paginate = val === true
      end

      def per_page(int)
        @_gear_per_page = int
      end

      def pagination_total(boolean)
        @_gear_pagination_total = boolean
      end
    end
  end
end
