Gearhead.register Comment, path: "/commentz" do
  finder do |params|
    @resource.find_by(id: params[:resource_id])
  end

  per_page 5

  collection_action :name do
    "hey"
  end
end
