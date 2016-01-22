# require 'rake'
# require 'rake/sprocketstask'
# require 'sprockets'
# require 'action_view'
# require 'action_view/base'

module Opal; module RSpec; module Rails

class Task < Rake::SprocketsTask
  DEFAULT_PORT = 9292

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

  def server
    @server ||= ::Opal::RSpec::Rails::Server.new(prefix: '/')
  end

  def port
    (ENV['PORT'] || DEFAULT_PORT).to_i
  end

  def runner
    @runner ||= begin
      require 'opal/cli_runners'
      runner_name = ENV['RUNNER'] || 'phantomjs'
      # p runner_name: runner_name, v: Opal::VERSION.to_f, a: [runner_name == 'server', Gem::Version.new(Opal::VERSION) < Gem::Version.new('0.10')]
      runner_class = ::Opal::CliRunners.const_get(runner_name.capitalize)

      case runner_class.instance_method(:initialize).arity
      when 1
        runner_class.new({})
      when 2
        runner_class.new(nil, port)
      else
        runner_class.new
      end
    end
  end

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
          Rack::Server.start app: server, Port: port
        end

        desc "Run the specs"
        task :run => :environment do
          # splitter = ARGV.index '--'
          args = []
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
