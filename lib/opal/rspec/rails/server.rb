module Opal
  module Rspec
    module Rails
      class Server < ::Opal::Server
        def initialize(**options)
          super(options.merge(sprockets: Rails.application.assets))
        end
      end
    end
  end
end
