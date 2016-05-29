require 'opal-rspec'

class Opal::RSpec::Rails::Server < ::Opal::Server
  def initialize(options = {})
    options ||= {}

    app    = Rails.application
    assets = app.config.opal_rspec.sprockets_instance || app.assets
    assets.append_path Opal::RSpec::Rails.root.join('opal').to_s
    assets.append_path p Rails.root.join(app.config.opal_rspec.spec_location).to_s

    super(options.merge(sprockets: assets))
  end

  def inspect
    "<#{self.class} debug=#{debug} use_index=#{use_index} public_root=#{public_root}>"
  end
end
