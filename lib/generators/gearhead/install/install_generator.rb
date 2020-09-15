module Gearhead
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Installs Gearhead"

      source_root File.expand_path("templates", __dir__)

      class_option :automount, default: false, desc: "Enable automounting (default is false)"
      class_option :endpoint, default: "/gearhead", desc: "The route to mount Gearhead on (default is /gearhead)"

      def generate_config_file
        @automount = options[:automount]
        @endpoint = options[:endpoint]
        Gearhead::Utils.check_endpoint!(@endpoint)

        template "gearhead.rb.erb", "config/initializers/gearhead.rb"
      end

      def install_routes
        inject_into_file "config/routes.rb", "\n  Gearhead.routes(self)", after: /Rails.application.routes.draw do/
      end
    end
  end
end
