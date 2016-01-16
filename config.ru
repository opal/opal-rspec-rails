# This file is used by Rack-based servers to start the application.

require 'bundler/setup'
require 'opal-rspec-rails'
require_relative './test_apps/app'
run RailsApp::Application
