module Gearhead
  module Extensions
    module CustomActions
      def self.included(klass)
        klass.define_gear_setting :collection_actions, {}
        klass.define_gear_setting :member_actions, {}
      end

      class CustomAction
        attr_reader :name, :verbs, :block
        def initialize(name, verbs, &block)
          @name = name
          @verbs = verbs
          @block = block
        end
      end

      def custom_action(type, name, options = {}, &block)
        vias = (Array(options[:via]).presence || [:get]).map { |via| via.downcase.to_sym }
        if type == :member
          @_gear_member_actions[name] = CustomAction.new(name, vias, &block)
        else
          @_gear_collection_actions[name] = CustomAction.new(name, vias, &block)
        end
      end

      def member_action(name, options = {}, &block)
        custom_action(:member, name, options, &block)
      end

      def collection_action(name, options = {}, &block)
        custom_action(:collection, name, options, &block)
      end
    end
  end
end
