require 'opal-rspec-rails/prelude'
require 'opal-rspec-rails/spec_files'

$spec_files.each(&method(:require))

# Patch the RSpec runner to work with Kernel.exit
RSpec::Core::Runner.class_eval do
  def self.autorun
    at_exit do
      # see NoCarriageReturnIO source for why this is being done (not on Node though)
      err, out = get_opal_closed_tty_io
      # Have to do this in 2 places. This will ensure the default formatter gets the right IO, but need to do this in config for custom formatters
      # that will be constructed BEFORE this runs, see rspec.rb
      run(ARGV, err, out).then do |status|
        exit 0
      end
    end
  end

  def self.exit_with_code(code)
    exit(code)
  end
end

RSpec::Core::Runner.autorun

exit
