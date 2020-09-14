Gearhead.register Person do
  collection_action :friends do
    { bob: "cool" }
  end

  member_action :unfriend do
    { result: true }
  end
end
