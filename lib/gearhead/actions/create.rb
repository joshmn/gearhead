module Gearhead
  module Actions
    class Create
      delegate_missing_to :@request

      def self.build(gear, request)
        new(gear, request).build
      end

      attr_reader :resource, :gear, :request
      def initialize(gear, request)
        @gear = gear
        @request = request
        @resource = new_resource
      end

      def build
        params = ParamsBuilder.new(self).for(:create)
        @resource.assign_attributes(params)
        @resource
      end

      private

      def new_resource
        @gear.resource.new
      end
    end
  end
end
