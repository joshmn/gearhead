module Gearhead
  module Serializers
    class InvalidRequestSerializer

      def initialize(request, message, status)
        @request = request
        @message = message
        @status = status
      end

      def as_json(options = nil)
        {}.tap do |hash|
          hash[:status] = @status
          hash[:url] = @request.url
          hash[:message] = @message
        end
      end

      def to_json(options = nil)
        as_json.to_json(options)
      end
    end
  end
end
