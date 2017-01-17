require 'http'

API_KEY = ENV['RIOT_API_KEY']

class RiotClient
  def initialize(region)
    @region = region
  end

  def fetchSummonerByName(sumName)
    url = "https://#{@region}.api.pvp.net/api/lol/#{@region}/v1.4/summoner/by-name/#{sumName}"
    response = HTTP.get(url, :params => { :api_key => API_KEY })

    if response.code == 200
      jsonData = response.parse.values[0]

      return {
        :summonerId => jsonData['id'],
        :name => jsonData['name'],
        :summonerLevel => jsonData['summonerLevel'],
        :profileIconId => jsonData['profileIconId'],
        :region => @region,
      }

    elsif response.code == 404
      raise EntityNotFoundError
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def fetchSummonerById(sumId)
    url = "https://#{@region}.api.pvp.net/api/lol/#{@region}/v1.4/summoner/#{sumId}"
    response = HTTP.get(url, :params => { :api_key => API_KEY })

    if response.code == 200
      jsonData = response.parse.values[0]

      return {
        :summonerId => jsonData['id'],
        :name => jsonData['name'],
        :summonerLevel => jsonData['summonerLevel'],
        :profileIconId => jsonData['profileIconId'],
        :region => @region,
      }

    elsif response.code == 404
      raise EntityNotFoundError
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def fetchSummonerRunes(sumId)
    url = "https://#{@region}.api.pvp.net/api/lol/#{@region}/v1.4/summoner/#{sumId}/runes"
    response = HTTP.get(url, :params => { :api_key => API_KEY })

    if response.code == 200
      jsonData = response.parse.values[0]
      groupPages = []

      jsonData['pages'].each do |page|
        groupRunes = []

        page['slots'].each do |slot|
          runeIndexInGrouped = groupRunes.index{|groupRune| groupRune[:runeId] == slot['runeId']}

          if runeIndexInGrouped != nil
            groupRunes[runeIndexInGrouped][:count] += 1
          else
            groupRunes.push({
                :runeId => slot['runeId'],
                :count => 1
            })
          end

          groupPages.push({
              :id => page['id'],
              :name => page['name'],
              :current => page['current'],
              :runes => groupRunes,
          })
        end
      end

      return {
        :summonerId => jsonData['summonerId'],
        :pages => groupPages,
        :region => @region,
      }

    elsif response.code == 404
      raise EntityNotFoundError
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end
end

class RiotCache
  def initialize(region)
    @region = region
  end

  def isOutDated(updatedAt, cacheMinutes)
    diffMin = (Time.zone.now - updatedAt) / 60

    if diffMin > cacheMinutes
      return true
    end

    return false
  end

  def findSummonerByName(sumName, cacheMinutes = 5)
    summoner = Summoner.find_by(:name => sumName, :region => @region)

    if summoner and self.isOutDated(summoner.updated_at, cacheMinutes)
      summoner = false
    end

    return summoner
  end

  def saveSummonerByName(sumData)
    sumFound = Summoner.find_by(:name => sumData[:name], :region => @region)

    if sumFound
      updateData = sumData.slice(:name, :summonerLevel, :profileIconId)
      sumFound.update(updateData)
    else
      Summoner.create(sumData)
    end
  end

  def findSummonerById(sumId, cacheMinutes = 5)
    summoner = Summoner.find_by(:summonerId => sumId, :region => @region)

    if summoner and self.isOutDated(summoner.updated_at, cacheMinutes)
      summoner = false
    end

    return summoner
  end

  def saveSummonerById(sumData)
    sumFound = Summoner.find_by(:summonerId => sumData[:summonerId], :region => @region)

    if sumFound
      updateData = sumData.slice(:name, :summonerLevel, :profileIconId)
      sumFound.update(updateData)
    else
      Summoner.create(sumData)
    end
  end

  def findSummonerRunes(sumId, cacheMinutes = 5)
    runes = Rune.find_by(:summonerId => sumId, :region => @region)

    if runes and self.isOutDated(runes.updated_at, cacheMinutes)
      runes = false
    end

    return runes
  end

  def saveSummonerRunes(runesData)
    runes = Rune.find_by(:summonerId => runesData[:summonerId], :region => @region)

    if runes
      updateData = runes.slice(:pages)
      runes.update(updateData)
    else
      Rune.create(runesData)
    end
  end
end

class RiotApi
  def initialize(region)
    @region = region
    @client = RiotClient.new(region)
    @cache = RiotCache.new(region)
  end

  def getSummonerByName(sumName)
      summoner = @cache.findSummonerByName(sumName)

      if summoner
        return summoner
      else
        summoner = @client.fetchSummonerByName(sumName)
        @cache.saveSummonerByName(summoner)
        return summoner
      end
  end

  def getSummonerById(sumId)
      summoner = @cache.findSummonerById(sumId)

      if summoner
        return summoner
      else
        summoner = @client.fetchSummonerById(sumId)
        @cache.saveSummonerById(summoner)
        return summoner
      end
  end

  def getSummonerRunes(sumId)
      runes = @cache.findSummonerRunes(sumId)

      if runes
        return runes
      else
        runes = @client.fetchSummonerRunes(sumId)
        @cache.saveSummonerRunes(runes)
        return runes
      end
  end
end
