require 'test_helper'

class SummonersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def testSummonerData(response)
    res = JSON.parse(response.body)['summoner']
    assert_instance_of(Hash, res)
    assert_instance_of(Integer, res['summonerId'], 'summonerId should be an Integer')
    assert_instance_of(Integer, res['profileIconId'], 'profileIconId should be an Integer')
    assert_instance_of(Integer, res['summonerLevel'], 'summonerLevel should be an Integer')
    assert_instance_of(String, res['region'], 'region should be a String')
  end

  test '#findByName should response the summonerData' do
    get '/riot-api/lan/summoner/by-name/armaghyon'
    assert_response(:success)
    testSummonerData(@response)
  end

  test '#findByName should response not_found' do
    testNotFoundResponse('/riot-api/lan/summoner/by-name/')
  end

  test '#findById should response the summonerData' do
    get '/riot-api/lan/summoner/75453'
    assert_response(:success)
    testSummonerData(@response)
  end

  test '#findById should response not_found' do
    testNotFoundResponse('/riot-api/lan/summoner/0')
  end

  test '#runes should response OK' do
    get '/riot-api/lan/summoner/75119/runes'
    assert_response(:success)
    res = JSON.parse(@response.body)['runes']
    assert_instance_of(Hash, res)
    assert_instance_of(Array, res['pages'])
    res['pages'].each { |page|
      assert_instance_of(String, page['name'])
      assert_instance_of(Array, page['runes'])
      page['runes'].each { |rune|
        assert_instance_of(Integer, rune['runeId'])
        assert_instance_of(Integer, rune['count'])
        assert(rune['count'].between?(1, 9))
        assert_instance_of(String, rune['name'])
        assert_instance_of(String, rune['description'])
        assert_instance_of(String, rune['image']['full'])
      }
    }
  end

  test '#runes should response NOT_FOUND' do
    testNotFoundResponse('/riot-api/lan/summoner/0/runes')
  end

  test '#masteries should response OK' do
    get '/riot-api/lan/summoner/75119/masteries'
    assert_response(:success)
    res = JSON.parse(@response.body)['masteries']
    assert_instance_of(Hash, res)
    assert_instance_of(Array, res['pages'])
    res['pages'].each { |page|
      assert_instance_of(String, page['name'])
      assert_instance_of(Array, page['masteries'])
      page['masteries'].each { |mastery|
        assert_instance_of(Integer, mastery['id'])
        assert(mastery['rank'].between?(1, 5))
      }
    }
  end

  test '#masteries should response NOT_FOUND' do
    testNotFoundResponse('/riot-api/lan/summoner/0/masteries')
  end

  test '#statsSummary should response OK' do
    get '/riot-api/lan/summoner/75119/stats/summary', params: { :season => 'SEASON2016' }
    assert_response(:success)
    res = JSON.parse(@response.body)['statsSummary']
    assert_instance_of(Hash, res)
    assert_instance_of(Array, res['playerStatSummaries'])
    assert_equal('SEASON2016', res['season'])
    res['playerStatSummaries'].each { |summary|
      assert_instance_of(String, summary['playerStatSummaryType'])
      assert_instance_of(Hash, summary['aggregatedStats'])
    }
  end

  test '#statsSummary of notFound summoner should response empty stats' do
    get '/riot-api/lan/summoner/0/stats/summary', params: { :season => 'SEASON2016' }
    assert_response(:success)
    res = JSON.parse(@response.body)['statsSummary']
    assert_instance_of(Hash, res)
    assert_instance_of(Array, res['playerStatSummaries'])
    assert_equal(0, res['playerStatSummaries'].length)
    assert_equal('SEASON2016', res['season'])
  end

  test '#championsMastery should response OK' do
    get '/riot-api/lan/summoner/75119/champions-mastery'
    assert_response(:success)
    res = JSON.parse(@response.body)['championsMastery']
    assert_instance_of(Hash, res)
    assert_instance_of(Array, res['masteries'])
    res['masteries'].each { |mastery|
      assert_instance_of(Integer, mastery['championId'])
      assert_instance_of(Integer, mastery['championLevel'])
      assert_instance_of(Integer, mastery['championPoints'])
      assert_instance_of(Hash, mastery['championData'])
      assert_instance_of(String, mastery['championData']['name'])
      assert_instance_of(String, mastery['championData']['title'])
    }
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
