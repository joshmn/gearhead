module Gearhead
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Installs Gearhead"

      source_root File.expand_path("templates", __dir__)

      def generate_config_file
        template "gearhead.rb.erb", "config/initializers/gearhead.rb"
      end

      def install_routes
        inject_into_file "config/routes.rb", "\n  mount ::Gearhead::Engine => \"/gearhead\"", after: /Rails.application.routes.draw do/
      end
    end
  end
end
