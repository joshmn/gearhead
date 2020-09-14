module Gearhead
  # not implemented
  class RansackConfiguration
    attr_accessor :enabled, :predicates, :associations, :attributes, :scopes
    def initialize
      @enabled = true
      @predicates = true
      @associations = true
      @attributes = true
      @scopes = true
    end

    def enabled?
      @enabled
    end
  end

  class SerializationConfiguration
    attr_accessor :adapter
    def initialize
      @adapter = :fast_jsonapi
    end
  end

  class PaginationConfiguration
    attr_accessor :adapter, :include_total, :per_page
    def initialize
      @adapter = :pagy
      @enabled = true
      @per_page = 30
    end

    def enabled?
      @enabled
    end
  end

  class AutomountConfiguration
    attr_accessor :enabled, :excludes, :includes

    def initialize
      @enabled = false
      @excludes = []
      @includes = []
    end

    def enabled?
      @enabled
    end
  end

  class Configuration
    attr_accessor :actions, :current_user, :serializer, :scope, :ignored_params,
                  :automount, :pagination, :serialization, :base_controller

    def initialize
      @actions = [:index, :create, :show, :update, :destroy]
      @current_user = nil
      @scope = nil
      @ignored_params = [:id, :created_at, :updated_at]
      @automount = AutomountConfiguration.new
      @pagination = PaginationConfiguration.new
      @serialization = SerializationConfiguration.new
      @base_controller = 'ApplicationController'
    end
  end
end
