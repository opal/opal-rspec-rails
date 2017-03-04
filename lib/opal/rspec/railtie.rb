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

  # Files to be preloaded when the specs are ran, this helps with dynamic
  # requires if you need to use spec patterns other than
  # the default '**/*_spec'.
  config.opal_rspec.preload = []

  initializer 'opal-rspec-rails' do |app|
    # @private
    # Cache the non-cached sprockets environment to be used
    # by the Opal::RSpec::Rails::Server.
    config.opal_rspec.sprockets_instance = app.assets
  end

  rake_tasks do |app|
    require 'opal/rspec/rails/task'
    Opal::RSpec::Rails::Task.new(app)
  end

  config.after_initialize do |app|
    config = app.config

    if config.opal_rspec.enable
      app.assets.append_path app.root.join(config.opal_rspec.spec_location)

      prefix      = config.opal_rspec.routing_path+'/assets'
      mount_point = config.opal_rspec.routing_path

      require 'opal/rspec/rails/server'
      server_app = Opal::RSpec::Rails::Server.new

      config.opal_rspec.server_app = server_app

      app.routes.prepend do
        mount config.opal_rspec.server_app, at: mount_point
      end
    end
  end
end
