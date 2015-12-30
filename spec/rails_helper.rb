require 'spec_helper'

root_dir = File.expand_path('../../', __FILE__)

require 'support/test_app'
require 'support/capybara'
require 'support/reset_assets_cache'

Rails.backtrace_cleaner.remove_silencers!

