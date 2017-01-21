require 'test_helper'
require 'json-schema'
require 'json_schemas'

class ProPlayersControllerTest < ActionDispatch::IntegrationTest
  test '#index should response ok' do
    get '/pro-players'
    assert_response(:success)
    res = getJsonResponse()
    assert(res['data'].length > 0, 'Should has one proPlayer at DB at least')
    JSON::Validator.validate!(JSON_SCHEMAS::ProPlayers, res['data'])
  end
end
