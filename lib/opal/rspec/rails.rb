require 'opal/rspec/rails/version'
require 'pathname'

module Opal
  module RSpec
    module Rails
      def self.root
        @root ||= Pathname("#{__dir__}/../../..")
      end
    end
  end
end

if defined? Rails::Railtie
  require 'opal/rspec/railtie'
end
