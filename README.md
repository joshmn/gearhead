# Gearhead test application

Gearhead turns your database into a RESTful API. It's like if ActiveAdmin and Grape had a baby.

## Installation

Gearhead is a Rails engine, for now.

```ruby
gem 'gearhead'
```

## Setting up Gearhead

After installing Gearhead, you need to run the generator.

```
rails g gearhead:install
```

which generates:

```
config/initializers/gearhead.rb
app/gears/.keep
```

and modifies your routes:

```ruby
mount ::Gearhead::Engine => '/api'
```

## Configuration

You can change most of these on the Gear-level, but we have opinions.

```ruby
Gearhead.configure do |config|
  ### Routing  
  # The default actions a Gear can respond to 
  # Default is [:index, :create, :show, :update, :destroy]
  # config.actions = [:index, :show]
  #
  #
  ### Queriyng
  # The default scope of a Gear will be the default scope of the resource.
  # Default is nil
  # config.scope = :visible
  #
  #
  ### Params
  # Ignored params for creating/updating records
  # Default is [:id, :created_at, :updated_at]
  # config.ignored_params = [:id, :created_at, :updated_at]
  #
  #
  ### Automount
  # Change this to true if you want to automatically mount all your resources.
  # config.automount.enabled = false 
  #
  # Automatically mount most of your resources
  # config.automount.resources = ['User', 'Post', 'Comment']
  #
  # Don't automatically mount these resources
  # config.automount.excluded = ['User', 'Post']
  #
  #
  ### Serialization
  # Change the default serializer   
  # Currently supports FastJSONAPI (:fast_jsonapi) and ActiveModelSerializers (:active_model_serializers)
  # Default is :fast_jsonapi
  # config.serialization.adapter = :fast_jsonapi 
  #
  #  
  ### Pagination
  # Change the default paginator 
  # Currently supports :pagy and :will_paginate
  # Default is :pagy
  # config.pagination.adapter = :pagy 
  #
  # Controller
  # Base class for the Gearhead controller
  # Default is 'ApplicationController'
  # config.base_controller = 'ApplicationController'
end
```

## Exposing your data

Gearhead does some metaprogramming to generate standard RESTful endpoints for your defined Rails models. They do this with Gears.

A Gear is responsible for configuring the controller, including resource retrieval, serialization, and response.

By default, Gearhead doesn't automatically mount all your resources. You can change this if you want in your initializer.

To create a Gear, drop it in `/app/gears` and register it with `Gearhead.register Model, options`. Prefer a constant over a string.

```ruby 
Gearhead.register Post; end
```

will generate `/posts` — or whatever `Model.model_name.route_key` is. Change the path:

```ruby
Gearhead.register Post, path: "postz"; end 
```

**A note about automount**: If you have automount enabled and call `/posts`, and you have explicitly defined this Gear,
the defined Gear will take precedence. If you define a custom path such as `postz` and navigate to `/posts` with automount 
enabled, the defined Gear will still take precedence.

## Customizing Gears

### Actions

Change what CRUD actions the Gear can respond to:

```
Gearhead.register Post do 
  actions :index, :show
  # or
  actions except: [:create, :update, :delete]
end
``` 

Want to expose `/posts/favorites`?

```ruby
Gearhead.register Post do 
  collection_action :favorites, via: :get do 
    # do something
  end
end
```

Expose `GET /posts/:id/report` and `POST /posts/:id/report`:

```ruby
Gearhead.register Post do 
  member_action :report, via: [:get, :post] do 
    if request.get? 
      resource.reports.all
    elsif request.post? 
      resource.reports.create!
    end
  end
end
```

### Handling pagination 

```ruby 
Gearhead.register Post do 
  per_page 5 
  # or disable it 
  pagination false 
end
```

### Serializing your objects

Just define what attributes you want exposed:

```ruby 
Gearhead.register Post do 
  attributes :id, :name
end
```

#### Finding resources

Change your finder:

```ruby 
Gearhead.register Post do 
  finder do 
    resource_class.find_by(token: params[:resource_id])
  end
end
```

## TODO

* Handle collection actions in a better way than hijacking `show`

## Contributing

Do things.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
