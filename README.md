![Gearhead logo](logo.png)

Gearhead turns your database into a RESTful API. It's like if [ActiveAdmin](https://github.com/activeadmin/activeadmin), [InheritedResources](https://github.com/activeadmin/inherited_resources), and [Grape](https://github.com/ruby-grape/grape) had a baby.

## Purpose

For internal projects I was always standing up API endpoints that were separate from my regular controllers. The boilerplate 
got old real fast. This eliminates boilerplate and leaves enough configuration for you to make it your own.

## Goal 

Rid the boilerplate for JSON APIs with opinions, while providing enough customization to work for most applications. 

## Installation

Gearhead is a Rails engine, for now.

```ruby
gem 'gearhead'
```

And then copy over the initializers: 

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
Gearhead.routes(self)
```

## Configuration

You can change most of these on the Gear-level, but we have opinions.

```ruby 
Gearhead.setup do |config|
  # == Routing
  #
  # The endpoint in which to mount gearhead on.
  # Default is "/gearhead" — must start with a slash, and have no trailing slash
  # config.endpoint = "/api/v314"
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
```

## Exposing your data

Gearhead does some metaprogramming to generate standard RESTful endpoints for your defined Rails models. They do this with Gears.

A Gear is responsible for configuring the controller, including resource retrieval, serialization, and response.

By default, Gearhead doesn't automatically mount all your resources. You can change this if you want in your initializer.

To create a Gear, drop it in `/app/gears` and register it with `Gearhead.register Model, options`. Prefer a constant over a string.

```ruby 
Gearhead.register Post; end
```

will generate `/gearhead/posts` — or whatever `Model.model_name.route_key` is. Change the path:

```ruby
Gearhead.register Post, path: "postz"; end 
```

**A note about automount**: If you have automount enabled and call `/posts`, and you have explicitly defined this Gear,
the defined Gear will take precedence. If you define a custom path such as `postz` and navigate to `/posts` with automount 
enabled, the defined Gear will still take precedence.

## Customizing Gears

### Actions

Change what CRUD actions the Gear can respond to:

```ruby
Gearhead.register Post do 
  actions :index, :show
  # or
  actions except: [:create, :update, :delete]
end
``` 

Want to expose `/gearhead/posts/favorites`?

```ruby
Gearhead.register Post do 
  collection_action :favorites, via: :get do 
    # do something
  end
end
```

Expose `GET /gearhead/posts/:id/report` and `POST /gearhead/posts/:id/report`:

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
  attributes :id, :title
end
```

And customize one-off attributes:

```ruby 
Gearhead.register Post do 
  attributes :id, :title

  attribute :excerpt do |resource|
    resource.content.first(100)
  end
end 
```

### Finding resources

Change your finder:

```ruby 
Gearhead.register Post do 
  finder do 
    resource_class.find_by(token: params[:resource_id])
  end
end
```

### Querying 

Uses [Ransack](https://github.com/activerecord-hackery/ransack) under the hood. Just send the normal `q` in the query, like:

`GET /gearhead/posts?q[user_id]=1`

### Permitting params

Works just like the params you're used to:

```ruby 
Gearhead.register Post do 
  permit_params :user_id, :content
  # or do it for a certain subset of actions
  permit_params :user_id, :content, only: :create 
  permit_params :content, only: :update
end
```

## TODO

* Better param handling
* Handling params for member actions and collection actions
* Callbacks 
* Documentation about authentication and `current_user`-ish stuff 
* Wiki 
* Logo 

## Contributing

Do things.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
