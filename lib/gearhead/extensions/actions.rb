module Gearhead
  module Extensions
    module Actions
      def self.included(klass)
        klass.define_gear_setting :enabled_actions, Gearhead.config.actions.map(&:to_sym)
      end

      def disable_actions(*actions)
        @_gear_enabled_actions -= actions.map(&:to_sym)
      end

      def actions(*args)
        options = args.extract_options!
        @_gear_enabled_actions = if options[:except]
                                   @_gear_enabled_actions - options[:except].map(&:to_sym)
                                 elsif options[:only]
                                   options[:only].map(&:to_sym)
                                 else
                                   args.map(&:to_sym)
                                 end
      end

      def action_enabled?(action)
        @_gear_enabled_actions.include?(action)
      end

    end
  end
end
