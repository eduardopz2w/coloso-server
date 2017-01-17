require 'http'

API_KEY = 'RGAPI-9938cbc8-8a46-43f2-babe-784c4ffe6814'

class EntityNotFoundError < StandardError
end

class RiotClient
  def initialize(region)
    @region = region
  end

  def fetchSummonerByName(sumName)
    url = "https://#{@region}.api.pvp.net/api/lol/#{@region}/v1.4/summoner/by-name/#{sumName}"
    response = HTTP.get(url, :params => { :api_key => API_KEY })

    if response.code == 200
      return response
    elsif response.code == 404
      raise EntityNotFoundError
    else
      raise RiotServerError
    end
  end
end

class RiotApi
  def initialize(region)
    @region = region
    @client = RiotClient.new(region)
  end
  def getSummonerByName(sumName)
    begin
      summoner = @client.fetchSummonerByName(sumName)
      puts summoner
    rescue EntityNotFoundError
      puts 'No encontrado'
    end
  end
end
