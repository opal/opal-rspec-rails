require 'bundler/setup'
require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

require_relative './test_apps/app'
Rails.application.load_tasks

task :default => :spec
