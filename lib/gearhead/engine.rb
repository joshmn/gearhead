module Gearhead
  class Engine < Rails::Engine
    config.to_prepare do
      Dir.glob(Rails.root.join("app/gears/**/*.rb")).each do |gear|
        load gear
      end

      # classic is Rails.autoloaders.main.nil? but let's be specific
      if Rails.autoloaders.main.is_a?(Zeitwerk::Loader)
        Rails.autoloaders.main.ignore(Rails.root.join('app/gears'))
      end
    end

    paths["app/controllers"] = "lib"
  end
end
