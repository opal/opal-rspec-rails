# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'opal/rspec/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "opal-rspec-rails"
  spec.version       = Opal::RSpec::Rails::VERSION
  spec.authors       = ["Elia Schito"]
  spec.email         = ["elia@schito.me"]

  spec.summary       = %q{Provides bindings between `opal-rails` and `opal-rspec`.}
  spec.description   = %q{Provides bindings between `opal-rails` and `opal-rspec`. Supports in browser specs as well as a rake task.}
  spec.homepage      = "https://opalrb.org/libraries"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'opal',       '>= 0.8'
  spec.add_dependency 'opal-rspec', '~> 0.5.0'
  spec.add_dependency 'opal-rails', '~> 0.9.0.dev'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'selenium-webdriver'
  spec.add_development_dependency 'launchy'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'coffee-rails', '~> 4.0.1'
end
