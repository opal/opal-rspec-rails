# Opal::RSpec::Rails

Provides bindings between `opal-rails` and `opal-rspec`.
Supports in browser specs as well as a rake task.

## Installation

Add this line to your Rails application's Gemfile:

```ruby
gem 'opal-rspec-rails'
```

And then execute:

    $ bundle


## Usage

Add specs into `/spec-opal`:

and then a spec folder with you specs!

```ruby
# /spec-opal/example_spec.js.rb
describe 'a spec' do
  it 'has successful examples' do
    'I run'.should =~ /run/
  end
end
```

Then visit `/spec-opal` from your app and **reload at will** or use the command line with `rake opal:spec`.

```ruby
# /spec-opal/example_spec.js.rb
require 'spec_helper'

describe 'a spec' do
  it 'has successful examples' do
    'I run'.should =~ /run/
  end
end
```

![1 examples, 0 failures](http://cl.ly/2j0N0R0C1c1f/Screen%20Shot%202016-01-02%20at%2000.26.43.png)


## Configuration

```ruby
# Enable or disable opal-rspec support, usually it's disabled in production.
config.opal_rspec.enable = ::Rails.env.development? || ::Rails.env.test?

# The path at which the embedded spec runner is mounted in your application.
config.opal_rspec.routing_path = '/spec-opal'

# The spec dir on the file system, relative from `Rails.root`.
config.opal_rspec.spec_location = 'spec-opal'
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/opal/opal-rspec-rails.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

