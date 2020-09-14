module Gearhead
  module Extensions
    module Scoping
      def self.included(klass)
        klass.define_gear_setting :default_scope, nil
        klass.define_gear_setting :defined_scopes, {}
      end

      def register_scope(name, query = nil)
        @_gear_defined_scopes[name] = query
      end

      def default_scope(scope = nil)
        @_gear_default_scope = scope
      end
    end
  end
end
