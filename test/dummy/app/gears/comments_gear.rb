Gearhead.register Comment, path: "commentz" do
  finder do |params|
    @resource.find_by(id: params[:resource_id])
  end

  belongs_to :person

  per_page 5

  collection_action :name do
    "hey"
  end

  member_action :fix do

  end
end
