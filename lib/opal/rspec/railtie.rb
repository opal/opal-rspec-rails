require 'rails'
require 'rails/railtie'
require 'sprockets/railtie'

require 'opal-rails'
require 'opal/rspec/rails'

class Opal::RSpec::Rails::Engine < ::Rails::Railtie
  config.opal_rspec = ActiveSupport::OrderedOptions.new

  config.opal_rspec.enable = ::Rails.env.development? || ::Rails.env.test?
  config.opal_rspec.routing_path = '/spec-opal'
  config.opal_rspec.spec_location = 'spec-opal'

  initializer 'opal-rspec-rails' do |app|
    # Cache the non-cached sprockets environment to be used
    # by the Opal::RSpec::Rails::Server.
    config.opal_rspec.sprockets_instance = app.assets
  end

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
  config.after_initialize do |app|
    config = app.config

    app.routes.prepend do
      if config.opal_rspec.enable
        require 'opal/rspec/rails/server'

        opal_rspec_server = Opal::RSpec::Rails::Server.new do |server|
          server.main = 'opal-rspec-rails-runner'
        end

        mount opal_rspec_server, at: config.opal_rspec.routing_path
      end
    end
  end
end
