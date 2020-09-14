module Gearhead
  module Extensions
    module EnabledActions
      def finder(&block)
        @_gear_finder = block
      end
    end
  end
end
