module Gearhead
  class Registry
    def initialize
      @resource_map = {}
      @router = {}
    end

    def register(gear)
      @resource_map[gear.resource.name] = gear
      @router[gear.path] = gear
      true
    end

    def for_resource(resource)
      @resource_map[resource]
    end

    def find(path)
      @router[path]
    end

    def all
      @resource_map.values
    end
  end
end
