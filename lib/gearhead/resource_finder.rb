module Gearhead
  class ResourceFinder
    def self.for(gear, params)
      new(gear, params).resource
    end

    def initialize(gear, params)
      @gear = gear
      @params = params
    end

    def resource
      if @gear._gear_finder.present?
        @gear._gear_finder.call(@params)
      else
        @gear.resource.find_by(@gear._gear_param_key => @params[:resource_id])
      end
    end
  end
end
