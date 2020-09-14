Gearhead.register Post do
  register_scope :visible
  register_scope :invisible, -> (query) { query.where(private: true) }

  default_scope :invisible
  attributes :id

  disable_actions :index
  actions :index, :create, :show, :update

  permit_params :person_id, :private
end
