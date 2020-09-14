Gearhead.setup do |config|
  # == Routing
  #
  # The default actions a Gear can respond to
  # Default is [:index, :create, :show, :update, :destroy]
  # config.actions = [:index, :show]
  #

  # == Querying
  #
  # The default scope of a Gear will be the default scope of the resource.
  # Default is nil
  # config.scope = :visible
  #

  # == Params
  #
  # Ignored params for creating/updating records
  # Default is [:id, :created_at, :updated_at]
  # config.ignored_params = [:id, :created_at, :updated_at]
  #

  # == Automount
  #
  # Change this to true if you want to automatically mount all your resources.
  # config.automount.enabled = false
  #
  # Automatically mount most of your resources
  # config.automount.resources = ['User', 'Post', 'Comment']
  #
  # Don't automatically mount these resources
  # config.automount.excluded = ['User', 'Post']
  #

  # == Serialization
  #
  # Change the default serializer
  # Currently supports FastJSONAPI (:fast_jsonapi) and ActiveModelSerializers (:active_model_serializers)
  # Default is :fast_jsonapi
  # config.serialization.adapter = :fast_jsonapi
  #

  # == Pagination
  #
  # Change the default paginator
  # Currently supports :pagy and :will_paginate
  # Default is :pagy
  # config.pagination.adapter = :pagy
  #

  # == Controller
  #
  # Base class for the Gearhead controller
  # Default is 'ApplicationController'
  # config.base_controller = 'ApplicationController'
  #
end
