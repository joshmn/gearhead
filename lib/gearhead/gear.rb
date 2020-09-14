module Gearhead
  module Settings
    def self.included(klass)
      klass.extend ClassMethods
      klass.class_attribute :settings, default: {}
    end

    def define_gear_setting(name, default = nil)
      instance_variable_set("@_gear_#{name}", default)
      ivar = "@_gear_#{name}"
      self.class.define_method :"_gear_#{name}" do
        return instance_variable_get(ivar) if instance_variable_defined?(ivar)
        instance_variable_get("@_gear_#{name}")
      end
      self.class.define_method :"_gear_#{name}=" do |value|
        instance_variable_set("@_gear_#{name}", value)
      end
    end

    module ClassMethods
      def define_gear_setting(name, default = nil)
        settings[name] = default
      end
    end
  end
  class Gear
    include Settings

    include Extensions::Actions
    include Extensions::Attributes
    include Extensions::Associations
    include Extensions::CustomActions
    include Extensions::Finder
    include Extensions::Pagination
    include Extensions::PermittedParams
    include Extensions::Querying
    include Extensions::Scoping
    include Extensions::Serialization

    attr_reader :resource

    def initialize(resource_class, options = {})
      @resource_class = resource_class
      @resource = @resource_class.to_s.constantize
      @options = options

      self.class.settings.each do |k,v|
        define_gear_setting k, v
      end
    end

    def path
      @options[:path] || @resource.model_name.route_key
    end
  end
end
