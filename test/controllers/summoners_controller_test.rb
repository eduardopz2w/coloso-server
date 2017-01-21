require 'test_helper'
require 'json-schema'
require 'json_schemas'

class SummonersControllerTest < ActionDispatch::IntegrationTest
  test '#findByName should response the summonerData' do
    get '/riot-api/lan/summoner/by-name/armaghyon'
    assert_response(:success)
    JSON::Validator.validate!(JSON_SCHEMAS::Summoner, getJsonResponse()['data'])
  end

  test '#findByName should response not_found' do
    testNotFoundResponse('/riot-api/lan/summoner/by-name/')
  end

  test '#findById should response the summonerData' do
    get '/riot-api/lan/summoner/75453'
    JSON::Validator.validate!(JSON_SCHEMAS::Summoner, getJsonResponse()['data'])
  end

  test '#findById should response not_found' do
    testNotFoundResponse('/riot-api/lan/summoner/0')
  end

  test '#runes should response OK' do
    get '/riot-api/lan/summoner/75119/runes'
    assert_response(:success)
    JSON::Validator.validate!(JSON_SCHEMAS::Runes, getJsonResponse()['data'])
  end

  test '#runes should response NOT_FOUND' do
    testNotFoundResponse('/riot-api/lan/summoner/0/runes')
  end

  test '#masteries should response OK' do
    get '/riot-api/lan/summoner/75119/masteries'
    assert_response(:success)
    JSON::Validator.validate!(JSON_SCHEMAS::Masteries, getJsonResponse()['data'])
  end

  test '#masteries should response NOT_FOUND' do
    testNotFoundResponse('/riot-api/lan/summoner/0/masteries')
  end

  test '#statsSummary should response OK' do
    get '/riot-api/lan/summoner/75119/stats/summary', params: { :season => 'SEASON2016' }
    assert_response(:success)
    JSON::Validator.validate!(JSON_SCHEMAS::StatsSummary, getJsonResponse()['data'])
  end

  test '#statsSummary of notFound summoner should response empty stats' do
    get '/riot-api/lan/summoner/0/stats/summary', params: { :season => 'SEASON2016' }
    assert_response(:success)
    JSON::Validator.validate!(JSON_SCHEMAS::StatsSummary, getJsonResponse()['data'])
  end

  test '#championsMastery should response OK' do
    get '/riot-api/lan/summoner/75119/champions-mastery'
    assert_response(:success)
    JSON::Validator.validate!(JSON_SCHEMAS::ChampionsMastery, getJsonResponse()['data'])
  end

  test '#championsMastery of notFound summoner should response empty masteries' do
    get '/riot-api/lan/summoner/0/champions-mastery'
    assert_response(:success)
    JSON::Validator.validate!(JSON_SCHEMAS::ChampionsMastery, getJsonResponse()['data'])
  end

  test '#gamesRecent should response OK' do
    get '/riot-api/lan/summoner/75119/games/recent'
    assert_response(:success)
    JSON::Validator.validate!(JSON_SCHEMAS::GamesRecent, getJsonResponse()['data'])
  end

  test '#gamesRecent of notFound summoner should response empty games' do
    get '/riot-api/lan/summoner/0/games/recent'
    assert_response(:success)
    JSON::Validator.validate!(JSON_SCHEMAS::GamesRecent, getJsonResponse()['data'])
  end
end
