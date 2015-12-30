require_relative './templates'
class ApplicationController < ActionController::Base
  include Rails.application.routes.url_helpers
  layout 'application'
  self.view_paths = [ActionView::FixtureResolver.new(TEMPLATES)]

  def index
  end

  def with_assignments
    object = Object.new
    def object.as_json options = {}
      {contents: 'json representation'}
    end

    @number_var = 1234
    @string_var = 'hello'
    @array_var  = [1,'a']
    @hash_var   = {a: 1, b: 2}
    @object_var = object

    render type: :js, locals: { local_var: 'i am local' }
  end
end

