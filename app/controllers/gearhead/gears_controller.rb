# todo:
if defined?(ActiveModelSerializers)
  ActiveModelSerializers.config.serializer_lookup_enabled = false
end

module Gearhead
  class GearsController < ::Gearhead.config.base_controller.constantize
    before_action :find_gear!
    before_action :ensure_action_enabled!, only: [:index, :create, :show, :update, :destroy]
    before_action :check_collection_actions!, only: [:show] # hack. bad hack.
    before_action :find_resource!, except: [:index, :create]

    def index
      render json: Gearhead::Actions::Index.build(@gear, request), adapter: false
    end

    def create
      @resource = Gearhead::Actions::Create.build(@gear, request)
      if @resource.save
        render json: @gear.serializer_class.new(@resource)
      else
        render json: { errors: @resource.errors }
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
        render json: { errors: @resource.errors }
      end
    end

    def destroy
      if @resource.destroy
        render json: @gear.serializer_class.new(resource)
      else
        render json: { errors: resource.errors }
      end
    end

    def member_action
      action = @gear._gear_member_actions[request.request_method][params[:member_action].to_sym]
      if action
        return render json: instance_exec(&action)
      end
    end

    private

    def find_gear!
      @gear = Gearhead.gear_for(request)
      return @gear if @gear

      if @gear.nil?
        error!("Can't find or infer gear.", 404)
      end
      if @gear == false
        error!("Gear already mounted somewhere else.", 500)
      end
    end

    # remember that request method is from rack so GET/POST/etc.
    def check_collection_actions!
      action = @gear._gear_collection_actions[request.request_method][params[:resource_id].to_sym]
      if action
        return render json: instance_exec(&action)
      end
    end

    def find_resource!
      @resource = ::Gearhead::ResourceFinder.for(@gear, params)
      error!("#{@gear.resource.name} not found for #{@gear._gear_param_key} #{params[:resource_id]}") if @resource.nil?
    end

    def ensure_action_enabled!
      unless @gear.action_enabled?(action_name.to_sym)
        error!("Action not allowed for #{@gear.resource.name}##{action_name}", 405)
      end
    end

    def error!(msg, code = 400)
      render json: Serializers::Lookup.for(:invalid_request).new(request, msg, code), serializer: nil
    end
  end
end
