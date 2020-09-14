$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "gearhead/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "gearhead"
  spec.version     = Gearhead::VERSION
  spec.authors     = ["Josh"]
  spec.email       = ["josh@josh.mn"]
  spec.homepage    = "https://github.com/joshmn/gearhead"
  spec.summary     = "Summary of Gearhead."
  spec.description = "Description of Gearhead."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.2"

  spec.add_development_dependency "pg"
  spec.add_development_dependency "ffaker"
  spec.add_development_dependency "will_paginate"
  spec.add_development_dependency "active_model_serializers"
  spec.add_development_dependency "better_errors"
  spec.add_development_dependency "binding_of_caller"

  spec.add_dependency 'ransack'
  spec.add_dependency 'jsonapi-serializer'
  spec.add_dependency 'pagy'
  spec.add_dependency 'zeitwerk'
end
