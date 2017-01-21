ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

module TestNotFoundResponse
  def testNotFoundResponse(url)
    get(url)
    assert_response(:not_found)
    res = JSON.parse(@response.body)
    assert_instance_of(String, res['message'])
  end

  def getJsonResponse
    return JSON.parse(@response.body)
  end
end

class ActionDispatch::IntegrationTest
  include TestNotFoundResponse
end
