module Gearhead
  class Engine < Rails::Engine
    config.to_prepare do
      Dir.glob(Rails.root.join("app/gears/**/*.rb")).each do |gear|
        load gear
      end
      Rails.autoloaders.main.ignore(Rails.root.join('app/gears'))
    end

    paths["app/controllers"] = "lib"
  end
end
