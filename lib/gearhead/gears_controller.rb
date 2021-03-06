# frozen_string_literal: true
if defined?(ActiveModelSerializers)
  ActiveModelSerializers.config.serializer_lookup_enabled = false
end

module Gearhead
  class GearsController < ::Gearhead.config.base_controller.constantize
    before_action :find_gear!
    before_action :ensure_action_enabled!, only: %i[index create show update destroy]
    before_action :find_resource!, except: %i[index create collection_action]

    def index
      render json: Gearhead::Actions::Index.build(@gear, request)
    end

    def create
      @resource = Gearhead::Actions::Create.build(@gear, request)
      if @resource.save
        render json: @gear.serializer_class.new(@resource)
      else
        render json: { errors: @resource.errors }, status: :unprocessable_entity
      end
    end

    def show
      @resource = Gearhead::Actions::Show.build(@gear, request, resource: @resource)
      render json: @gear.serializer_class.new(@resource)
    end

    def update
      @resource = Gearhead::Actions::Update.build(@gear, request, resource: @resource)
      if @resource.save
        render json: @gear.serializer_class.new(@resource)
      else
        render json: { errors: @resource.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      if @resource.destroy
        render json: @gear.serializer_class.new(resource)
      else
        render json: { errors: @resource.errors }, status: :unprocessable_entity
      end
    end

    def member_action
      action = @gear._gear_member_actions[params[:member_action].to_sym]
      if action&.verbs&.include?(request.request_method.to_sym.downcase)
        render json: instance_exec(&action.block)
      end
    end

    def collection_action
      action = @gear._gear_collection_actions[params[:collection_action]]
      if action&.verbs&.include?(request.request_method.to_sym.downcase)
        render json: instance_exec(&action.block)
      end
    end

    private

    def find_gear!
      @gear = Gearhead.gear_for(request)
      return @gear if @gear

      error!("Can't find or infer gear.", 404) if @gear.nil?
      error!('Gear already mounted somewhere else.', 500) if @gear == false
    end

    # remember that request method is from rack so GET/POST/etc.
    def check_collection_actions!
      action = @gear._gear_collection_actions[request.request_method][params[:resource_id].to_sym]
      return render json: instance_exec(&action) if action
    end

    def find_resource!
      @resource = ::Gearhead::ResourceFinder.for(@gear, params)
      if @resource.nil?
        error!("#{@gear.resource.name} not found for #{@gear._gear_param_key} #{params[:resource_id]}")
      end
    end

    def ensure_action_enabled!
      unless @gear.action_enabled?(action_name.to_sym)
        error!("Action not allowed for #{@gear.resource.name}##{action_name}", :method_not_allowed)
      end
    end

    def error!(msg, code = 400)
      render json: Serializers::Lookup.for(:invalid_request).new(request, msg, code)
    end
  end
end
