module Gearhead
  module Extensions
    module Associations
      def self.included(klass)
        klass.define_gear_setting :associations, { belongs_to: [], has_many: [], has_one: [] }
      end

      def belongs_to(klass)
        @_gear_associations[:belongs_to] << klass
      end
    end
  end
end
