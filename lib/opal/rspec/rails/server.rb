require 'opal-rspec'

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
