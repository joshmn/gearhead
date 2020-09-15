module Gearhead
  class Router
    attr_reader :router

    def initialize(router:)
      @router = router
    end

    def apply
      if Gearhead.config.automount.enabled?
        define_automount_route
      end
      define_gear_routes
    end

    def define_automount_route
      @router.resources :gears, path: [::Gearhead.config.endpoint, ":resource_class"].join("/"), controller: "gearhead/gears", param: :resource_id
    end

    def define_gear_routes
      ::Gearhead.registry.all.each do |thing|
        @router.resources thing.resource.model_name.route_key, path: [::Gearhead.config.endpoint, thing.path].join("/"), controller: "gearhead/gears", param: :resource_id, defaults: { resource_class: thing.resource.model_name.route_key } do
          define_actions(thing)
        end
      end
    end

    def define_actions(gear)
      @router.member do
        gear._gear_member_actions.values.each do |custom_action|
          custom_action.verbs.each do |verb|
            args = [custom_action.name, to: 'gearhead/gears#member_action', defaults: { member_action: custom_action.name }]
            router.send(verb, *args)
          end
        end
      end

      @router.collection do
        gear._gear_collection_actions.values.each do |custom_action|

          custom_action.verbs.each do |verb|

            args = [custom_action.name, to: 'gearhead/gears#collection_action', defaults: { collection_action: custom_action.name }]
            router.send(verb, *args)
          end
        end
      end
    end

    def build_action(action)
      build_route(action.verbs, action.name)
    end

    def build_route(verbs, *args)
      Array.wrap(verbs).each { |verb| router.send(verb, *args) }
    end
  end
end
