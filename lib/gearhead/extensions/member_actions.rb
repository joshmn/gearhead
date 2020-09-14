module Gearhead
  module Extensions
    module MemberActions
      def self.included(klass)
        klass.define_gear_setting :member_actions, Hash.new({})
      end

      def member_action(name, options = {}, &block)
        vias = (Array(options[:via]) || ["GET"]).map { |via| via.to_s.upcase }
        vias.each do |via|
          @_gear_member_actions[via][name] = block
        end
      end
    end
  end
end
