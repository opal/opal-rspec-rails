require 'rails_helper'
require 'execjs'

describe 'the /opal-rspec route' do
  it 'is aliased to /opal_spec for legacy support'
  it 'allows the use of other non-opal assets'
  it 'runs the specs successfully'
  it 'allows running the specs based on a pattern'
  it 'allows running the specs for a single file'
end

describe 'the `rake opal:spec` command' do
  it 'allows the use of other non-opal assets'
  it 'runs the specs successfully'
  it 'allows running the specs based on a pattern'
  it 'allows running the specs for a single file'
end
