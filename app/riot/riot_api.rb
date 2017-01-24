require 'http'

API_KEY = ENV['RIOT_API_KEY']

def regionToPlatform(region)
  if region == 'BR'
    return 'br1'
  elsif region == 'EUNE'
    return 'eun1'
  elsif region == 'EUW'
    return 'euw1'
  elsif region == 'JP'
    return 'jp1'
  elsif region == 'KR'
    return 'kr'
  elsif region == 'LAN'
    return 'la1'
  elsif region == 'LAS'
    return 'la2'
  elsif region == 'NA'
    return 'na1'
  elsif region == 'OCE'
    return 'oc1'
  elsif region == 'RU'
    return 'ru'
  end
end

module RiotClient
  def self.fetchSummonerByName(sumName, region)
    url = "https://#{region.downcase}.api.pvp.net/api/lol/#{region.downcase}/v1.4/summoner/by-name/#{sumName}"
    response = HTTP.get(url, :params => { :api_key => API_KEY })

    if response.code == 200
      jsonData = response.parse.values[0]

      return {
        :urid => URID.Generate(jsonData['id'], region),
        :name => jsonData['name'],
        :summonerLevel => jsonData['summonerLevel'],
        :profileIconId => jsonData['profileIconId'],
        :region => region,
      }

    elsif response.code == 404
      raise EntityNotFoundError
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def self.fetchSummonerByUrid(urid)
    region = URID.GetRegion(urid)
    sumId = URID.GetId(urid)
    url = "https://#{region.downcase}.api.pvp.net/api/lol/#{region}/v1.4/summoner/#{sumId}"
    response = HTTP.get(url, :params => { :api_key => API_KEY })

    if response.code == 200
      jsonData = response.parse.values[0]

      return {
        :urid => urid,
        :name => jsonData['name'],
        :summonerLevel => jsonData['summonerLevel'],
        :profileIconId => jsonData['profileIconId'],
        :region => region,
      }

    elsif response.code == 404
      raise EntityNotFoundError
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def self.fetchSummonerRunes(sumUrid)
    region = URID.GetRegion(sumUrid)
    url = "https://#{region.downcase}.api.pvp.net/api/lol/#{region.downcase}/v1.4/summoner/#{URID.GetId(sumUrid)}/runes"
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

      return { 'summonerUrid' => sumUrid, 'pages' => groupPages}

    elsif response.code == 404
      raise EntityNotFoundError
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def self.fetchSummonerMasteries(sumUrid)
    region = URID.GetRegion(sumUrid)
    url = "https://#{region.downcase}.api.pvp.net/api/lol/#{region.downcase}/v1.4/summoner/#{URID.GetId(sumUrid)}/masteries"
    response = HTTP.get(url, :params => { :api_key => API_KEY })

    if response.code == 200
      jsonData = response.parse.values[0]

      return {
        :summonerUrid => sumUrid,
        :pages => jsonData['pages'],
      }

    elsif response.code == 404
      raise EntityNotFoundError
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def self.fetchSummonerChampionsMastery(sumUrid)
    region = URID.GetRegion(sumUrid)
    platform = regionToPlatform(region)
    url = "https://#{region.downcase}.api.pvp.net/championmastery/location/#{platform}/player/#{URID.GetId(sumUrid)}/topchampions"
    response = HTTP.get(url, :params => { :api_key => API_KEY, :count => 200 })

    if response.code == 200
      return {
        :summonerUrid => sumUrid,
        :masteries => response.parse,
      }

    elsif response.code == 404
      return {
        :summonerUrid => sumUrid,
        :masteries => [],
      }
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def self.fetchSummonerStatsSummary(sumUrid, season = 'SEASON2017')
    region = URID.GetRegion(sumUrid)
    url = "https://#{region.downcase}.api.pvp.net/api/lol/#{region.downcase}/v1.3/stats/by-summoner/#{URID.GetId(sumUrid)}/summary"
    response = HTTP.get(url, :params => { :api_key => API_KEY, :season => season })

    if response.code == 200
      return {
        :summonerUrid => sumUrid,
        :season => season,
        :playerStatSummaries => response.parse['playerStatSummaries'],
      }

    elsif response.code == 404
      return {
        :summonerUrid => sumUrid,
        :season => season,
        :playerStatSummaries => [],
      }
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def self.fetchSummonersLeagueEntries(sumUrids)
    region = URID.GetRegion(sumUrids[0])
    sumIds = sumUrids.map { |sumUrid| URID.GetId(sumUrid) }

    url = "https://#{region.downcase}.api.pvp.net/api/lol/#{region.downcase}/v2.5/league/by-summoner/#{sumIds.join(',')}/entry"
    response = HTTP.get(url, :params => { :api_key => API_KEY})

    if response.code == 200
      jsonResponse = response.parse
      leagueEntries = []

      sumIds.each do |sumId|
        if jsonResponse.has_key?(sumId.to_s)
          leagueEntries.push(
            :summonerUrid => URID.Generate(sumId, region),
            :entries => jsonResponse[sumId.to_s],
          )
        else
          leagueEntries.push(
            :summonerUrid => URID.Generate(sumId, region),
            :entries => [],
          )
        end
      end

      return leagueEntries
    elsif response.code == 404
      leagueEntries = []

      sumIds.each do |sumId|
        leagueEntries.push({
            :summonerUrid => URID.Generate(sumId, region),
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

  def self.fetchSummonerGamesRecent(sumUrid)
    region = URID.GetRegion(sumUrid)
    url = "https://#{region.downcase}.api.pvp.net/api/lol/#{region.downcase}/v1.3/game/by-summoner/#{URID.GetId(sumUrid)}/recent"
    response = HTTP.get(url, :params => { :api_key => API_KEY})

    if response.code == 200
      jsonResponse = response.parse

      games = jsonResponse['games'].each { |game|
        game['fellowPlayers'] = game['fellowPlayers'].each { |player|
          player['summonerUrid'] = URID.Generate(player['summonerId'], region)
          player.delete('summonerId')
          player
        }
        game
      }
      return {
        :summonerUrid => sumUrid,
        :games => games,
      }
    elsif response.code == 404
      return {
        :summonerUrid => sumUrid,
        :games => [],
      }
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def self.fetchSummonerGameCurrent(sumUrid)
    region = URID.GetRegion(sumUrid)
    platform = regionToPlatform(region)
    url = "https://#{region.downcase}.api.pvp.net/observer-mode/rest/consumer/getSpectatorGameInfo/#{platform}/#{URID.GetId(sumUrid)}"
    response = HTTP.get(url, :params => { :api_key => API_KEY})

    if response.code == 200
      jsonResponse = response.parse

      gameData = jsonResponse
      gameData['focusSummonerUrid'] = sumUrid
      gameData['region'] = URID.GetRegion(sumUrid)

      gameData['participants'] = gameData['participants'].map { |participant|
        participant['summonerUrid'] = URID.Generate(participant['summonerId'], region)
        participant.delete('summonerId')
        participant
      }

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

module RiotCache
  def self.isOutDated(updatedAt, cacheMinutes)
    diffMin = (Time.zone.now - updatedAt) / 60

    if diffMin > cacheMinutes
      return true
    end

    return false
  end

  def self.findSummonerByName(sumName, region, cacheMinutes = 5)
    summoner = Summoner.find_by(:name => sumName, :region => region)

    if summoner and self.isOutDated(summoner.updated_at, cacheMinutes)
      summoner = false
    end

    return summoner
  end

  def self.saveSummonerByName(sumData)
    sumFound = Summoner.find_by(:name => sumData[:name], :region => sumData[:region])

    if sumFound
      sumFound.update(sumData.slice(:name, :summonerLevel, :profileIconId))
      sumFound.touch()

      return sumFound
    else
      return Summoner.create(sumData)
    end
  end

  def self.findSummonerById(sumUrid, cacheMinutes = 5)
    summoner = Summoner.find_by(:urid => sumUrid)

    if summoner and self.isOutDated(summoner.updated_at, cacheMinutes)
      summoner = false
    end

    return summoner
  end

  def self.saveSummonerById(sumData)
    sumFound = Summoner.find_by(:urid => sumData[:urid])

    if sumFound
      sumFound.update(sumData.slice(:name, :summonerLevel, :profileIconId))
      sumFound.touch()

      return sumFound
    else
      return Summoner.create(sumData)
    end
  end

  def self.findSummonerRunes(sumUrid, cacheMinutes = 5)
    runes = Rune.find_by(:summonerUrid => sumUrid)

    if runes and self.isOutDated(runes.updated_at, cacheMinutes)
      return false
    end

    return runes
  end

  def self.saveSummonerRunes(runesData)
    runes = Rune.find_by(:summonerUrid => runesData['summonerUrid'])

    if runes
      runes.update(runesData.slice('pages'))
      runes.touch()
      return runes
    else
      return Rune.create(runesData)
    end
  end

  def self.findSummonerMasteries(sumUrid, cacheMinutes = 5)
    masteries = Mastery.find_by(:summonerUrid => sumUrid)

    if masteries and self.isOutDated(masteries.updated_at, cacheMinutes)
      masteries = false
    end

    return masteries
  end

  def self.saveSummonerMasteries(masteriesData)
    masteries = Mastery.find_by(:summonerUrid => masteriesData[:summonerUrid])

    if masteries
      masteries.update(masteriesData.slice(:pages))
      masteries.touch()
      return masteries
    else
      return Mastery.create(masteriesData)
    end
  end

  def self.findSummonerChampionsMastery(sumUrid, cacheMinutes = 5)
    masteries = ChampionsMastery.find_by(:summonerUrid => sumUrid)

    if masteries and self.isOutDated(masteries.updated_at, cacheMinutes)
      return false
    end

    return masteries
  end

  def self.saveSummonerChampionsMastery(masteriesData)
    masteries = ChampionsMastery.find_by(:summonerUrid => masteriesData[:summonerUrid])

    if masteries
      masteries.update(masteriesData.slice(:masteries))
      masteries.touch
      return masteries
    else
      return ChampionsMastery.create(masteriesData)
    end
  end

  def self.findSummonerStatsSummary(sumUrid, season, cacheMinutes = 5)
    stats = StatsSummary.find_by(:summonerUrid => sumUrid, :season => season)

    if stats and self.isOutDated(stats.updated_at, cacheMinutes)
      stats = false
    end

    return stats
  end

  def self.saveSummonerStatsSummary(statsData)
    stats = StatsSummary.find_by(:summonerUrid => statsData[:summonerUrid], :season => statsData[:season])

    if stats
      stats.update(statsData.slice(:playerStatSummaries))
      stats.touch
      return stats
    else
      return StatsSummary.create(statsData)
    end
  end

  def self.findSummonersLeagueEntries(sumUrids, cacheMinutes = 5)
    leagueEntries = LeagueEntry.where(:summonerUrid => sumUrids)

    if leagueEntries.length != sumUrids.length
      return false
    end

    leagueEntries.each do |leagueEntry|
      if self.isOutDated(leagueEntry.updated_at, cacheMinutes)
        return false
      end
    end

    return leagueEntries
  end

  def self.saveSummonersLeagueEntries(leagueEntries)
    entries = []

    leagueEntries.each do |leagueEntry|
      leagueEntryFound = LeagueEntry.find_by(:summonerUrid => leagueEntry[:summonerUrid])

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

  def self.findSummonerGamesRecent(sumUrid, cacheMinutes = 5)
    games = GamesRecent.find_by(:summonerUrid => sumUrid)

    if games and self.isOutDated(games.updated_at, cacheMinutes)
      games = false
    end

    return games
  end

  def self.saveSummonerGamesRecent(gamesData)
    games = GamesRecent.find_by(:summonerUrid => gamesData[:summonerUrid])

    if games
      games.update(gamesData.slice(:games))
      games.touch()
      return games
    else
      return GamesRecent.create(gamesData)
    end
  end
end

module RiotApi

  def self.getSummonerByName(sumName, region)
      summoner = RiotCache.findSummonerByName(sumName, region)

      if summoner
        return summoner
      else
        sumData = RiotClient.fetchSummonerByName(sumName, region)
        summoner = RiotCache.saveSummonerByName(sumData)
        return summoner
      end
  end

  def self.getSummonerById(sumUrid)
      summoner = RiotCache.findSummonerById(sumUrid)

      if summoner
        return summoner
      else
        sumData = RiotClient.fetchSummonerByUrid(sumUrid)
        summoner = RiotCache.saveSummonerById(sumData)
        return summoner
      end
  end

  def self.getSummonerRunes(sumUrid)
      runes = RiotCache.findSummonerRunes(sumUrid)

      if runes
        return runes
      else
        runesData = RiotClient.fetchSummonerRunes(sumUrid)
        runes = RiotCache.saveSummonerRunes(runesData)
        return runes
      end
  end

  def self.getSummonerMasteries(sumUrid)
      masteries = RiotCache.findSummonerMasteries(sumUrid)

      if masteries
        return masteries
      else
        masteriesData = RiotClient.fetchSummonerMasteries(sumUrid)
        masteries = RiotCache.saveSummonerMasteries(masteriesData)
        return masteries
      end
  end

  def self.getSummonerChampionsMastery(sumUrid)
      masteries = RiotCache.findSummonerChampionsMastery(sumUrid)

      if masteries
        return masteries
      else
        masteriesData = RiotClient.fetchSummonerChampionsMastery(sumUrid)
        masteries = RiotCache.saveSummonerChampionsMastery(masteriesData)
        return masteries
      end
  end

  def self.getSummonerStatsSummary(sumUrid, season)
      stats = RiotCache.findSummonerStatsSummary(sumUrid, season)

      if stats
        return stats
      else
        statsData = RiotClient.fetchSummonerStatsSummary(sumUrid, season)
        stats = RiotCache.saveSummonerStatsSummary(statsData)
        return stats
      end
  end

  def self.getSummonerLeagueEntry(sumUrid)
      leagueEntries = RiotCache.findSummonersLeagueEntries([sumUrid])

      if leagueEntries
        return leagueEntries[0]
      else
        leagueEntriesData = RiotClient.fetchSummonersLeagueEntries([sumUrid])
        leagueEntries = RiotCache.saveSummonersLeagueEntries(leagueEntriesData)
        return leagueEntries[0]
      end
  end

  def self.getSummonersLeagueEntry(sumUrids)
      leagueEntries = RiotCache.findSummonersLeagueEntries(sumUrids)

      if leagueEntries
        return leagueEntries
      else
        leagueEntriesData = RiotClient.fetchSummonersLeagueEntries(sumUrids)
        leagueEntries = RiotCache.saveSummonersLeagueEntries(leagueEntriesData)
        return leagueEntries
      end
  end

  def self.getSummonerGamesRecent(sumUrid)
      games = RiotCache.findSummonerGamesRecent(sumUrid)

      if games
        return games
      else
        gamesData = RiotClient.fetchSummonerGamesRecent(sumUrid)
        games = RiotCache.saveSummonerGamesRecent(gamesData)
        return games
      end
  end

  def self.getSummonerGameCurrent(sumUrid)
    game = RiotClient.fetchSummonerGameCurrent(sumUrid)

    sumUrids = []
    game['participants'].each { |participant| sumUrids.push(participant['summonerUrid'])}

    leagueEntries = self.getSummonersLeagueEntry(sumUrids)

    game['participants'].each do |participant|
      sumUrid = participant['summonerUrid']

      participant['leagueEntry'] = leagueEntries.find{ |leagueEntry| leagueEntry['summonerUrid'] == sumUrid }
    end

    return game
  end
end
