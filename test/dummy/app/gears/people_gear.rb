Gearhead.register Person do
  serializer_adapter :active_model_serializers
  per_page 1

  attributes :age
  attribute :id do |resource|
    "bob-#{resource.id}"
  end
end
