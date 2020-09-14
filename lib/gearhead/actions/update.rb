module Gearhead
  module Actions
    class Update
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

      # todo
      def build
        params = ActionController::Parameters.new(@request.params).require(:post).permit(:person_id, :private)
        @resource.assign_attributes(params)
        @resource
      end
    end
  end
end
