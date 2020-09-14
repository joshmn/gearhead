module Gearhead
  module Actions
    class Show
      delegate_missing_to :@request

      def self.build(gear, request, resource:)
        new(gear, request, resource: resource).build
      end

      attr_reader :resource, :gear, :request
      def initialize(gear, request, resource:)
        @gear = gear
        @request = request
        @resource = resource
      end

      def build
        @resource
      end
    end
  end
end
