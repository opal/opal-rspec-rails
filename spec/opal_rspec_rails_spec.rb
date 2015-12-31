require 'spec_helper'

Capybara.default_max_wait_time = 20

describe Opal::RSpec::Rails do
  specify '.root', :focus do
    expect(File.expand_path(described_class.root)).to eq(File.expand_path("#{__dir__}/.."))
  end
end

describe 'the /opal-rspec route', type: :feature, js: true do
  it 'allows the use of other non-opal assets'

  fit 'runs the specs successfully' do
    visit '/spec-opal'
    expect(page).to have_content('1 example, 0 failures')
  end

  it 'allows running the specs based on a pattern'
  it 'allows running the specs for a single file'
end

describe 'the `rake opal:spec` command' do
  it 'allows the use of other non-opal assets'
  it 'runs the specs successfully'
  it 'allows running the specs based on a pattern'
  it 'allows running the specs for a single file'
end


# describe 'controller assignments' do
#   it 'are in the template' do
#     source = get_source_of '/application/with_assignments.js'
#     source.gsub!(/;\s*\Z/,'') # execjs eval doesn't like the trailing semicolon
#     assignments = opal_eval(source)
#
#     {
#       :number_var => 1234,
#       :string_var => 'hello',
#       :array_var  => [1,'a'],
#       :hash_var   => {:a => 1, :b => 2}.stringify_keys,
#       :object_var => {:contents => 'json representation'}.stringify_keys,
#       :local_var  => 'i am local',
#     }.each_pair do |ivar, assignment|
#       assignments[ivar.to_s].should eq(assignment)
#     end
#   end
#
#   def get_source_of path
#     get path
#     response.should be_success
#     source = response.body
#   end
#
#   def opal_eval source
#     builder = Opal::Builder.new
#     builder.build 'opal'
#
#     # Any lib should be already required in the page,
#     # require won't work in this kind of templates.
#     builder.build 'native'
#
#     context = ExecJS.compile builder.to_s
#     context.eval source
#   rescue
#     $!.message << "\n\n#{source}"
#     raise
#   end
# end
