module Gearhead
  module Utils
    module_function

    def check_endpoint!(endpoint)
      return if endpoint.start_with?("/") && !endpoint.end_with?("/")
      unless endpoint.start_with?("/")
        raise ArgumentError, "Endpoint must start with /. Endpoint is: `#{endpoint}'"
      end
      if endpoint.end_with?("/")
        raise ArgumentError, "Endpoint must not end with /. Endpoint is: `#{endpoint}'"
      end
    end
  end
end
