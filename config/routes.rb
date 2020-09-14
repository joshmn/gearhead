Gearhead::Engine.routes.draw do
  scope module: :gearhead do
    resources :gears, path: ':resource_class', param: :resource_id do
      member do
        match ':member_action' => 'gears#member_action', via: :all
      end
    end
  end
end
