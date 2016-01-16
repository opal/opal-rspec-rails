ENV['RAILS_ENV'] = 'test'
ENV['DATABASE_URL'] = 'sqlite3::memory:'

require 'rails'
rails_version = Rails::VERSION::MAJOR
require_relative "./rails#{rails_version}"
