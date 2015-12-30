require 'rails'
require 'opal/sprockets/server'
require 'opal/sprockets/processor'
require 'opal/rails/spec_builder'

module Opal
  module Rspec
    module Rails
      class Engine < ::Rails::Engine
        # config.opal.enable_specs = ::Rails.env.development? || ::Rails.env.test?
        #
        # # new default location, override-able in a Rails initializer
        # config.opal.spec_location = 'spec-opal'
        #
        # initializer 'opal.asset_paths', :after => 'sprockets.environment', :group => :all do |app|
        #   if app.config.opal.enable_specs
        #     spec_location = app.root.join(app.config.opal.spec_location).to_s
        #     runner_dir = ::Opal::Rails::SpecBuilder.runner_dir(app.root)
        #     runner_dir.mkpath
        #
        #     app.assets.append_path runner_dir.to_s
        #     app.assets.append_path spec_location
        #   end
        #
        #   Opal.paths.each do |path|
        #     app.assets.append_path path
        #   end
        # end
        #
        # config.after_initialize do |app|
        #   config = app.config
        #   config.opal.each_pair do |key, value|
        #     key = "#{key}="
        #     Opal::Processor.send(key, value) if Opal::Processor.respond_to? key
        #   end
        #
        #   app.routes.prepend do
        #     if app.config.opal.enable_specs
        #       get '/opal-rspec' => 'opal/rspec#run', as: :opal_spec
        #     end
        #   end
        # end
      end
    end
  end
end
