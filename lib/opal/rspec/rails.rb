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

require 'opal/rspec/railtie'
