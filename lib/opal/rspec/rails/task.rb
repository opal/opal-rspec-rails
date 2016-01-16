# require 'rake'
# require 'rake/sprocketstask'
# require 'sprockets'
# require 'action_view'
# require 'action_view/base'

module Opal; module RSpec; module Rails

class Task < Rake::SprocketsTask
  attr_accessor :app

  def initialize(app = nil)
    self.app = app
    super()
  end

  def environment
    if app
      app.assets
    else
      super
    end
  end

  def output
    if app
      File.join(app.root, 'public', app.config.assets.prefix)
    else
      super
    end
  end

  def assets
    if app
      app.config.assets.precompile
    else
      super
    end
  end

  def manifest
    if app
      Sprockets::Manifest.new(index, output, app.config.assets.manifest)
    else
      super
    end
  end

  def cache_path
    if app
      "#{app.config.root}/tmp/cache/assets"
    else
      @cache_path
    end
  end
  attr_writer :cache_path

  def define
    namespace :opal do
      namespace :rspec do
        # Override this task change the loaded dependencies
        desc "Load asset compile environment"
        task :environment do
          # Load full Rails environment by default
          Rake::Task['environment'].invoke
        end

        desc "Run the specs server"
        task :server => :environment do |t, args|
          # TODO
        end

        desc "Run the specs"
        task :run => :environment do
          # splitter = ARGV.index '--'
          args = []

          require 'opal/cli_runners'

          server = ::Opal::RSpec::Rails::Server.new(prefix: '/')
          runner = ::Opal::CliRunners::Phantomjs.new
          code   = server.sprockets['opal-rspec-rails-runner.js'].to_s
          code  += Opal::Sprockets.load_asset("opal-rspec-rails-runner", server.sprockets)

          runner.run code, args
        end
      end

      task :rspec => 'opal:rspec:run'
    end
  end
end

end; end; end
