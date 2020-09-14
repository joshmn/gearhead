module Gearhead
  class GearLookup
    def self.for(request)
      new(request).gear
    end

    attr_reader :request
    def initialize(request)
      @request = request
    end

    # if the resource is already mounted, we don't want to expose it twice. return false
    # return nil if we don't know the class
    def gear
      registered_gear = Gearhead.registry.find(request.params[:resource_class])
      return registered_gear if registered_gear
      return nil if inferred_resource_class.nil?
      return false if Gearhead.registry.for_resource(inferred_resource_class.name)

      default_gear
    end

    private

    def default_gear
      return nil unless Gearhead.config.automount.enabled?

      Gear.new(inferred_resource_class)
    end

    def inferred_resource_class
      request.params[:resource_class].classify.safe_constantize
    end
  end
end
