module Gearhead
  module Extensions
    module Finder
      def self.included(klass)
        klass.define_gear_setting :finder, nil
        klass.define_gear_setting :param_key, :id
      end

      def finder(&block)
        @_gear_finder = block
      end
    end
  end
end
