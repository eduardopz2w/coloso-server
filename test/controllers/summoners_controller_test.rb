require 'test_helper'
require 'json-schema'
require 'json_schemas'

class SummonersControllerTest < ActionDispatch::IntegrationTest
  test '#findByName should response the summonerData' do
    get '/riot-api/lan/summoner/by-name/armaghyon'
    assert_response(:success)
    JSON::Validator.validate!(JSON_SCHEMAS::Summoner, getJsonResponse())
  end

  test '#findByName should response not_found' do
    testNotFoundResponse('/riot-api/lan/summoner/by-name/')
  end

  test '#findById should response the summonerData' do
    get '/riot-api/lan/summoner/75453'
    JSON::Validator.validate!(JSON_SCHEMAS::Summoner, getJsonResponse())
  end

  test '#findById should response not_found' do
    testNotFoundResponse('/riot-api/lan/summoner/0')
  end

  test '#runes should response OK' do
    get '/riot-api/lan/summoner/75119/runes'
    assert_response(:success)
    JSON::Validator.validate!(JSON_SCHEMAS::Runes, getJsonResponse())
  end

  test '#runes should response NOT_FOUND' do
    testNotFoundResponse('/riot-api/lan/summoner/0/runes')
  end

  test '#masteries should response OK' do
    get '/riot-api/lan/summoner/75119/masteries'
    assert_response(:success)
    JSON::Validator.validate!(JSON_SCHEMAS::Masteries, getJsonResponse())
  end

  test '#masteries should response NOT_FOUND' do
    testNotFoundResponse('/riot-api/lan/summoner/0/masteries')
  end

  test '#statsSummary should response OK' do
    get '/riot-api/lan/summoner/75119/stats/summary', params: { :season => 'SEASON2016' }
    assert_response(:success)
    JSON::Validator.validate!(JSON_SCHEMAS::StatsSummary, getJsonResponse())
  end

  test '#statsSummary of notFound summoner should response empty stats' do
    get '/riot-api/lan/summoner/0/stats/summary', params: { :season => 'SEASON2016' }
    assert_response(:success)
    JSON::Validator.validate!(JSON_SCHEMAS::StatsSummary, getJsonResponse())
  end

  test '#championsMastery should response OK' do
    get '/riot-api/lan/summoner/75119/champions-mastery'
    assert_response(:success)
    JSON::Validator.validate!(JSON_SCHEMAS::ChampionsMastery, getJsonResponse())
  end

  test '#championsMastery of notFound summoner should response empty masteries' do
    get '/riot-api/lan/summoner/0/champions-mastery'
    assert_response(:success)
    res = JSON.parse(@response.body)['championsMastery']
    assert_instance_of(Hash, res)
    assert_instance_of(Array, res['masteries'])
    assert_equal(0, res['masteries'].length)
  end

  test '#gamesRecent should response OK' do
    get '/riot-api/lan/summoner/75119/games/recent'
    assert_response(:success)
    res = JSON.parse(@response.body)['gamesRecent']
    assert_instance_of(Hash, res)
    assert_instance_of(Array, res['games'])
  end

  test '#gamesRecent of notFound summoner should response empty games' do
    get '/riot-api/lan/summoner/0/games/recent'
    assert_response(:success)
    res = JSON.parse(@response.body)['gamesRecent']
    assert_instance_of(Hash, res)
    assert_instance_of(Array, res['games'])
    assert_equal(0, res['games'].length)
  end
end
