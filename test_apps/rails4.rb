# FROM: http://www.rubytutorial.io/how-to-test-your-gem-against-multiple-rails/

require 'rails'
require 'rails/all'
require 'action_view/testing/resolvers'

require 'opal-rails'
require 'opal-rspec-rails' # our gem

module RailsApp
  class Application < Rails::Application
    config.root                                       = __dir__
    config.cache_classes                              = false
    config.eager_load                                 = false
    config.serve_static_files                         = true
    config.static_cache_control                       = 'public, max-age=3600'
    config.consider_all_requests_local                = true
    config.action_controller.perform_caching          = false
    config.action_dispatch.show_exceptions            = false
    config.action_controller.allow_forgery_protection = false
    config.active_support.deprecation                 = :stderr
    config.secret_key_base                            = '49837489qkuweoiuoqwe'

    config.middleware.delete 'Rack::Lock'
    config.middleware.delete 'ActionDispatch::Flash'
    config.middleware.delete 'ActionDispatch::BestStandardsSupport'

    routes.append do
      get '/' => 'application#index'
      get '/application/with_assignments' => 'application#with_assignments'
    end

    config.assets.paths << File.join(__dir__, 'assets/javascripts')
    config.assets.debug = true

    # Opal specific:
    config.opal.source_map_enabled = true
  end
end

require_relative './application_controller'

RailsApp::Application.initialize!
