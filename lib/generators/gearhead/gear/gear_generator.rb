require "active_admin/generators/boilerplate"

module ActiveAdmin
  module Generators
    class ResourceGenerator < Rails::Generators::NamedBase
      desc "Registers resources with Gearhead"

      source_root File.expand_path("templates", __dir__)

      def generate_config_file
        template "gear.rb.erb", "app/gears/#{file_path.tr('/', '_').pluralize}.rb"
      end

    end
  end
end
