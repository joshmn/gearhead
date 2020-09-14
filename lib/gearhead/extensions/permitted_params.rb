module Gearhead
  module Extensions
    module PermittedParams
      def self.included(klass)
        klass.define_gear_setting :permitted_params, {}
        klass.define_gear_setting :action_params, {}
      end

      def permit_params(*args)
        options = args.extract_options!
        if options[:only]
          keys = Array(args[:only]).map(&:to_sym)
          keys.each do |key|
            @_gear_action_params[key] = args
          end
        else
          @_gear_permitted_params = args
        end
      end

      def permitted_attributes(action)
        if attrs = @_gear_action_params[action.to_sym].presence
          attrs
        elsif attrs = @_gear_permitted_params.presence
          attrs
        else
          @resource.columns_hash.keys.map(&:to_sym)
        end
      end

      def permitted_params(action)
        permitted_attributes(action)
      end
    end
  end
end
