require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module Gearhead
  def self.gearbox
    @gearbox ||= Gearbox.new
  end

  def self.routes(rails_router)
    gearbox.routes(rails_router)
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.setup
    gearbox.setup!
    yield config
    gearbox.prepare!
  end

  def self.register(resource_class, options = {}, &block)
    gear = Gear.new(resource_class, options)
    gear.instance_exec(&block)
    registry.register(gear)
  end

  def self.registry
    @registry ||= Registry.new
  end

  def self.gear_for(request)
    GearLookup.for(request)
  end
end

# things that don't support autoloading

require 'gearhead/engine'
require 'pagy'
require 'jsonapi/serializer'
