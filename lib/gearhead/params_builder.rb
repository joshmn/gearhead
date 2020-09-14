module Gearhead
  class ParamsBuilder
    def initialize(page)
      @page = page
    end

    def for(action)
      params = @page.gear.permitted_params(action).map.with_object({}) do |key, obj|
        obj[key] = @page.request.params[key]
      end
      params
    end
  end
end
