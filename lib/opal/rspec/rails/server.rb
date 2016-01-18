require 'opal-rspec'

# Avoid double slashes for Opal < v0.10+
::Opal::Server::Index.class_eval do
  def javascript_include_tag name
    sprockets = @server.sprockets
    prefix = @server.prefix
    debug = @server.debug

    prefix = prefix.chop if prefix.end_with? '/'

    ::Opal::Sprockets.javascript_include_tag(name, sprockets: sprockets, prefix: prefix, debug: debug)
  end
end if Opal::VERSION.to_f < 0.10

class Opal::RSpec::Rails::Server < ::Opal::Server
  def initialize(options = {})
    options ||= {}

    app    = Rails.application
    assets = app.config.opal_rspec.sprockets_instance || app.assets
    assets.append_path Opal::RSpec::Rails.root.join('opal').to_s
    assets.append_path Rails.root.join(app.config.opal_rspec.spec_location).to_s

    super(options.merge(sprockets: assets)) do |server|
      server.main = 'opal-rspec-rails-runner'
    end
  end

  def inspect
    "<#{self.class} debug=#{debug} use_index=#{use_index} public_root=#{public_root}>"
  end
end
