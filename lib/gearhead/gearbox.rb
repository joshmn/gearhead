module Gearhead
  class Gearbox
    def initialize
    end

    def setup!
      # nothing
    end

    def prepare!
      ActiveSupport::Dependencies.autoload_paths -= load_paths
      Rails.application.config.eager_load_paths -= load_paths
      attach_reloader
    end

    # Event that gets triggered on load of Active Admin
    BeforeLoadEvent = "gearbox.application.before_load".freeze
    AfterLoadEvent = "gearbox.application.after_load".freeze

    def load!
      unless loaded?
        ActiveSupport::Notifications.publish BeforeLoadEvent, self # before_load hook
        files.each { |file| load file } # load files
        ActiveSupport::Notifications.publish AfterLoadEvent, self # after_load hook
        @@loaded = true
      end
    end

    def files
      load_paths.flatten.compact.uniq.flat_map { |path| Dir["#{path}/**/*.rb"] }.sort
    end

    def load_paths
      [File.expand_path("app/gears", Rails.root)]
    end

    def loaded?
      @@loaded ||= false
    end

    def unload!
      @@loaded = false
    end

    def routes(rails_router)
      load!
      Router.new(router: rails_router).apply
    end

    private

    def attach_reloader
      Rails.application.config.after_initialize do |app|
        unload_gearhead = -> { Gearhead.gearbox.unload! }

        if app.config.reload_classes_only_on_change
           ActiveSupport::Reloader.to_prepare(prepend: true, &unload_gearhead)
        else
          ActiveSupport::Reloader.to_complete(&unload_gearhead)
        end

        admin_dirs = {}

        load_paths.each do |path|
          admin_dirs[path] = [:rb]
        end

        routes_reloader = app.config.file_watcher.new([], admin_dirs) do
          app.reload_routes!
        end

        app.reloaders << routes_reloader

        ActiveSupport::Reloader.to_prepare do
           unless Gearhead.gearbox.loaded?
            routes_reloader.execute_if_updated
            Gearhead.application.load!
          end
        end
      end
    end
  end
end
