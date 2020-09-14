module Gearhead
  module Extensions
    module CollectionActions
      def self.included(klass)
        klass.define_gear_setting :collection_actions, Hash.new({})
      end

      def collection_action(name, options = {}, &block)
        vias = (Array(options[:via]) || ["GET"]).map { |via| via.to_s.upcase }
        vias.each do |via|
          @_gear_collection_actions[via][name] = block
        end
      end
    end
  end
end
