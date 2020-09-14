module Gearhead
  module Generators
    class InstallGeneartor < Rails::Generators::NamedBase
      desc "Installs Gearhead"

      source_root File.expand_path("templates", __dir__)

      def copy_initializer
        template "gearhead.rb.erb", "config/initializers/gearhead.rb"
      end
    end
  end
end
