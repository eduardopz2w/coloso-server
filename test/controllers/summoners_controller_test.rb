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
end
