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

    def pathbuilder(resource)
      resource.model_name.collection
    end

    def check_path!(path)
      return if path.start_with?("/") && !path.end_with?("/")
      unless path.start_with?("/")
        raise ArgumentError, "path must start with /. path is: `#{path}'"
      end
      if path.end_with?("/")
        raise ArgumentError, "path must not end with /. path is: `#{path}'"
      end
      path
    end
  end
end
