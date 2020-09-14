module Gearhead
  module Serializers
    class InvalidResourceSerializer
      attr_reader :resource, :errors
      alias_method :serializable_hash, :as_json
      alias_method :serialized_json, :to_json

      def initialize(resource, options = {})
        @resource = resource
        @errors = errors_for(resource).flatten
      end

      def id
        resource.id.to_s
      end

      def type
        resource.class.name.downcase
      end

      def serializable_hash(options = nil)
        {}.tap do |hash|
          hash[:id] = id if has_id?
          hash[:type] = type if has_id?
          hash[:errors] = errors
        end
      end

      def serialized_json(options = nil)
        serializable_hash.to_json(options)
      end

      private

      def has_id?
        @resource.respond_to?(:id)
      end

      def errors_for(resource)
        resource.errors.messages.map do |field, errors|
          build_hashes_for(field, errors)
        end
      end

      def build_hashes_for(field, errors)
        errors.map do |error_message|
          build_hash_for(field, error_message)
        end
      end

      def build_hash_for(field, error_message)
        {}.tap do |hash|
          hash[:source] = {pointer: "/data/attributes/#{field}"}
          hash[:detail] = error_message
        end
      end
    end
  end
end
