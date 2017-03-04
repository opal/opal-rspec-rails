require 'opal'
require 'opal-rspec'
require 'native'
require 'console'
require 'opal/platform'
require 'opal/rspec'
require 'rspec'

class Opal::RSpec::QueryStringConfig
  def initialize(string)
    @query_string = string
    @params = parse_query_string(string)
  end

  def [] name
    @params.select {|(k,_v)| k == name}.map(&:last)
  end

  def pattern
    self[:pattern].first || '.*/.*_spec'
  end

  def pattern_regexp
    Regexp.new(pattern)
  end

  def files
    self[:files].to_s.split(':')
  end

  module Utils
    def parse_query_string(string)
      string[1..-1].to_s.split('&').map {|param| p(param).split('=', 2)}
    end
  end

  include Utils
end

query_config = Opal::RSpec::QueryStringConfig.new(`String(window.location.search)`)

all_loaded_files = Hash.new(`Opal.modules`).keys
all_files        = query_config.files.any? ? query_config.files : all_loaded_files
matching_files   = all_loaded_files.grep(query_config.pattern_regexp)
p matching_files: matching_files, query: query_config.pattern_regexp, loaded: all_loaded_files.grep(/_spec/), explicit: query_config.files
matching_files.each { |file| require file }
