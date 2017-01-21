require 'test_helper'
require 'json-schema'
require 'json_schemas'

class ProBuildsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test '#index should response OK' do
    get '/pro-builds', params: { pageSize: 1 }
    json = getJsonResponse()
    JSON::Validator.validate!(JSON_SCHEMAS::ProBuilds, json)
  end

  test '#show should response OK' do
    get '/pro-builds/1'
    json = getJsonResponse()
    JSON::Validator.validate!(JSON_SCHEMAS::ProBuild, json)
  end
end
