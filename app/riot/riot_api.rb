require 'http'

API_KEY = ENV['RIOT_API_KEY']

def regionToPlatform(region)
  if region == 'br'
    return 'br1'
  elsif region == 'eune'
    return 'eun1'
  elsif region == 'euw'
    return 'euw1'
  elsif region == 'jp'
    return 'jp1'
  elsif region == 'kr'
    return 'kr'
  elsif region == 'lan'
    return 'la1'
  elsif region == 'las'
    return 'la2'
  elsif region == 'na'
    return 'na1'
  elsif region == 'oce'
    return 'oc1'
  elsif region == 'ru'
    return 'ru'
  end
end

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
        if page['slots'].nil?
          page['slots'] = []
        end

        page['slots'].each do |slot|
          runeIndexInGrouped = groupRunes.index{|groupRune| groupRune['runeId'] == slot['runeId']}

          if runeIndexInGrouped != nil
            groupRunes[runeIndexInGrouped]['count'] += 1
          else
            groupRunes.push({
                'runeId' => slot['runeId'],
                'count' => 1
            })
          end

          groupPages.push({
              'id' => page['id'],
              'name' => page['name'],
              'current' => page['current'],
              'runes' => groupRunes,
          })
        end
      end

      return { 'summonerId' => jsonData['summonerId'], 'pages' => groupPages, 'region' => @region }

    elsif response.code == 404
      raise EntityNotFoundError
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def fetchSummonerMasteries(sumId)
    url = "https://#{@region}.api.pvp.net/api/lol/#{@region}/v1.4/summoner/#{sumId}/masteries"
    response = HTTP.get(url, :params => { :api_key => API_KEY })

    if response.code == 200
      jsonData = response.parse.values[0]

      return {
        :summonerId => jsonData['summonerId'],
        :pages => jsonData['pages'],
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

  def fetchSummonerChampionsMastery(sumId)
    url = "https://#{@region}.api.pvp.net/championmastery/location/#{regionToPlatform(@region)}/player/#{sumId}/topchampions"
    response = HTTP.get(url, :params => { :api_key => API_KEY, :count => 200 })

    if response.code == 200
      return {
        'summonerId' => sumId,
        'region' => @region,
        'masteries' => response.parse,
      }

    elsif response.code == 404
      return {
        'summonerId' => sumId,
        'region' => @region,
        'masteries' => [],
      }
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def fetchSummonerStatsSummary(sumId, season = 'SEASON2017')
    url = "https://#{@region}.api.pvp.net/api/lol/#{@region}/v1.3/stats/by-summoner/#{sumId}/summary"
    response = HTTP.get(url, :params => { :api_key => API_KEY, :season => season })

    if response.code == 200
      return {
        :summonerId => sumId,
        :region => @region,
        :season => season,
        :playerStatSummaries => response.parse['playerStatSummaries'],
      }

    elsif response.code == 404
      return {
        :summonerId => sumId,
        :region => @region,
        :season => season,
        :playerStatSummaries => [],
      }
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def fetchSummonersLeagueEntries(sumIds)
    url = "https://#{@region}.api.pvp.net/api/lol/#{@region}/v2.5/league/by-summoner/#{sumIds.join(',')}/entry"
    response = HTTP.get(url, :params => { :api_key => API_KEY})

    if response.code == 200
      jsonResponse = response.parse
      leagueEntries = []

      sumIds.each do |sumId|
        if jsonResponse.has_key?(sumId.to_s)
          leagueEntries.push(
            :summonerId => sumId,
            :region => @region,
            :entries => jsonResponse[sumId.to_s],
          )
        else
          leagueEntries.push(
            :summonerId => sumId,
            :region => @region,
            :entries => [],
          )
        end
      end

      return leagueEntries
    elsif response.code == 404
      leagueEntries = []

      sumIds.each do |sumId|
        leagueEntries.push({
            :summonerId => sumId,
            :region => @region,
            :entries => [],
        })
      end

      return leagueEntries
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def fetchSummonerGamesRecent(sumId)
    url = "https://#{@region}.api.pvp.net/api/lol/#{@region}/v1.3/game/by-summoner/#{sumId}/recent"
    response = HTTP.get(url, :params => { :api_key => API_KEY})

    if response.code == 200
      jsonResponse = response.parse

      return {
        :summonerId => jsonResponse['summonerId'],
        :region => @region,
        :games => jsonResponse['games'],
      }
    elsif response.code == 404
      raise EntityNotFoundError
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def fetchSummonerGameCurrent(sumId)
    url = "https://#{@region}.api.pvp.net/observer-mode/rest/consumer/getSpectatorGameInfo/#{regionToPlatform(@region)}/#{sumId}"
    response = HTTP.get(url, :params => { :api_key => API_KEY})

    if response.code == 200
      jsonResponse = response.parse

      gameData = jsonResponse
      gameData['focusSummonerId'] = sumId
      gameData['regio'] = @region

      return gameData
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
      sumFound.update(sumData.slice(:name, :summonerLevel, :profileIconId))
      sumFound.touch()

      return sumFound
    else
      return Summoner.create(sumData)
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
      sumFound.update(sumData.slice(:name, :summonerLevel, :profileIconId))
      sumFound.touch()

      return sumFound
    else
      return Summoner.create(sumData)
    end
  end

  def findSummonerRunes(sumId, cacheMinutes = 5)
    runes = Rune.find_by(:summonerId => sumId, :region => @region)

    if runes and self.isOutDated(runes.updated_at, cacheMinutes)
      return false
    end

    return runes
  end

  def saveSummonerRunes(runesData)
    runes = Rune.find_by(:summonerId => runesData['summonerId'], 'region' => @region)

    if runes
      runes.update(runesData.slice('pages'))
      runes.touch()
      return runes
    else
      return Rune.create(runesData)
    end
  end

  def findSummonerMasteries(sumId, cacheMinutes = 0)
    masteries = Mastery.find_by(:summonerId => sumId, :region => @region)

    if masteries and self.isOutDated(masteries.updated_at, cacheMinutes)
      masteries = false
    end

    return masteries
  end

  def saveSummonerMasteries(masteriesData)
    masteries = Mastery.find_by(:summonerId => masteriesData[:summonerId], :region => @region)

    if masteries
      masteries.update(masteriesData.slice(:pages))
      masteries.touch()
      return masteries
    else
      return Mastery.create(masteriesData)
    end
  end

  def findSummonerChampionsMastery(sumId, cacheMinutes = 5)
    masteries = ChampionsMastery.find_by(:summonerId => sumId, :region => @region)

    if masteries and self.isOutDated(masteries.updated_at, cacheMinutes)
      return false
    end

    return masteries
  end

  def saveSummonerChampionsMastery(masteriesData)
    masteries = ChampionsMastery.find_by(:summonerId => masteriesData[:summonerId], :region => @region)

    if masteries
      masteries.update(masteriesData.slice(:masteries))
      masteries.touch
      return masteries
    else
      return ChampionsMastery.create(masteriesData)
    end
  end

  def findSummonerStatsSummary(sumId, season, cacheMinutes = 5)
    stats = StatsSummary.find_by(:summonerId => sumId, :region => @region, :season => season)

    if stats and self.isOutDated(stats.updated_at, cacheMinutes)
      stats = false
    end

    return stats
  end

  def saveSummonerStatsSummary(statsData)
    stats = StatsSummary.find_by(:summonerId => statsData[:summonerId], :region => @region, :season => statsData[:season])

    if stats
      stats.update(statsData.slice(:playerStatSummaries))
      stats.touch
      return stats
    else
      return StatsSummary.create(statsData)
    end
  end

  def findSummonersLeagueEntries(sumIds, cacheMinutes = 5)
    leagueEntries = LeagueEntry.where(:summonerId => sumIds, :region => @region)

    if leagueEntries.length != sumIds.length
      return false
    end

    leagueEntries.each do |leagueEntry|
      if self.isOutDated(leagueEntry.updated_at, cacheMinutes)
        return false
      end
    end

    return leagueEntries
  end

  def saveSummonersLeagueEntries(leagueEntries)
    entries = []

    leagueEntries.each do |leagueEntry|
      leagueEntryFound = LeagueEntry.find_by(:summonerId => leagueEntry[:summonerId], :region => @region)

      if leagueEntryFound
        leagueEntryFound.update(leagueEntry.slice(:entries))
        leagueEntryFound.touch
        entries.push(leagueEntryFound)
      else
        entries.push(LeagueEntry.create(leagueEntry))
      end
    end

    return entries
  end

  def findSummonerGamesRecent(sumId, cacheMinutes = 5)
    games = GamesRecent.find_by(:summonerId => sumId, :region => @region)

    if games and self.isOutDated(games.updated_at, cacheMinutes)
      games = false
    end

    return games
  end

  def saveSummonerGamesRecent(gamesData)
    games = GamesRecent.find_by(:summonerId => gamesData[:summonerId], :region => @region)

    if games
      games.update(gamesData.slice(:games))
      games.touch()
      return games
    else
      return GamesRecent.create(gamesData)
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
        sumData = @client.fetchSummonerByName(sumName)
        summoner = @cache.saveSummonerByName(sumData)
        return summoner
      end
  end

  def getSummonerById(sumId)
      summoner = @cache.findSummonerById(sumId)

      if summoner
        return summoner
      else
        sumData = @client.fetchSummonerById(sumId)
        summoner = @cache.saveSummonerById(sumData)
        return summoner
      end
  end

  def getSummonerRunes(sumId)
      runes = @cache.findSummonerRunes(sumId)

      if runes
        return runes
      else
        runesData = @client.fetchSummonerRunes(sumId)
        runes = @cache.saveSummonerRunes(runesData)
        return runes
      end
  end

  def getSummonerMasteries(sumId)
      masteries = @cache.findSummonerMasteries(sumId)

      if masteries
        return masteries
      else
        masteriesData = @client.fetchSummonerMasteries(sumId)
        masteries = @cache.saveSummonerMasteries(masteriesData)
        return masteries
      end
  end

  def getSummonerChampionsMastery(sumId)
      masteries = @cache.findSummonerChampionsMastery(sumId)

      if masteries
        return masteries
      else
        masteriesData = @client.fetchSummonerChampionsMastery(sumId)
        masteries = @cache.saveSummonerChampionsMastery(masteriesData)
        return masteries
      end
  end

  def getSummonerStatsSummary(sumId, season)
      stats = @cache.findSummonerStatsSummary(sumId, season)

      if stats
        return stats
      else
        statsData = @client.fetchSummonerStatsSummary(sumId, season)
        stats = @cache.saveSummonerStatsSummary(statsData)
        return stats
      end
  end

  def getSummonerLeagueEntry(sumId)
      leagueEntries = @cache.findSummonersLeagueEntries([sumId])

      if leagueEntries
        return leagueEntries[0]
      else
        leagueEntriesData = @client.fetchSummonersLeagueEntries([sumId])
        leagueEntries = @cache.saveSummonersLeagueEntries(leagueEntriesData)
        return leagueEntries[0]
      end
  end

  def getSummonersLeagueEntry(sumIds)
      leagueEntries = @cache.findSummonersLeagueEntries(sumIds)

      if leagueEntries
        return leagueEntries
      else
        leagueEntriesData = @client.fetchSummonersLeagueEntries(sumIds)
        leagueEntries = @cache.saveSummonersLeagueEntries(leagueEntriesData)
        return leagueEntries
      end
  end

  def getSummonerGamesRecent(sumId)
      games = @cache.findSummonerGamesRecent(sumId)

      if games
        return games
      else
        gamesData = @client.fetchSummonerGamesRecent(sumId)
        games = @cache.saveSummonerGamesRecent(gamesData)
        return games
      end
  end

  def getSummonerGameCurrent(sumId)
    game = @client.fetchSummonerGameCurrent(sumId)

    sumIds = []
    game['participants'].each { |participant| sumIds.push(participant['summonerId'])}

    leagueEntries = self.getSummonersLeagueEntry(sumIds)

    game['participants'].each do |participant|
      sumId = participant['summonerId']

      participant['leagueEntry'] = leagueEntries.find{ |leagueEntry| leagueEntry['summonerId'] == sumId }
    end

    return game
  end
end
