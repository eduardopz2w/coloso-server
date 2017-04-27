require 'http'

API_KEY = ENV['RIOT_API_KEY']

def regionToPlatform(region)
  region = region.upcase

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
  elsif region == 'TR'
    return 'tr1'
  end
end

module RiotClient
  def self.fetchSummonerByName(sumName, region)
    url = "https://#{regionToPlatform(region)}.api.riotgames.com/lol/summoner/v3/summoners/by-name/#{sumName}"
    response = HTTP.get(url, :params => { :api_key => API_KEY })

    if response.code == 200
      jsonData = response.parse

      return {
        :id => URID.Generate(jsonData['id'], region),
        :name => jsonData['name'],
        :summonerLevel => jsonData['summonerLevel'],
        :profileIconId => jsonData['profileIconId'],
        :accountId => jsonData['accountId'],
        :region => region.upcase,
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
    url = "https://#{regionToPlatform(region)}.api.riotgames.com/lol/summoner/v3/summoners/#{sumId}"
    response = HTTP.get(url, :params => { :api_key => API_KEY })

    if response.code == 200
      jsonData = response.parse

      return {
        :id => urid,
        :name => jsonData['name'],
        :summonerLevel => jsonData['summonerLevel'],
        :profileIconId => jsonData['profileIconId'],
        :accountId => jsonData['accountId'],
        :region => region.upcase,
      }

    elsif response.code == 404
      raise EntityNotFoundError
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def self.fetchSummonerRunes(sumId)
    region = URID.GetRegion(sumId)
    url = "https://#{regionToPlatform(region)}.api.riotgames.com/lol/platform/v3/runes/by-summoner/#{URID.GetId(sumId)}"
    response = HTTP.get(url, :params => { :api_key => API_KEY })

    if response.code == 200
      jsonData = response.parse
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

        end

        groupPages.push({
          'id' => page['id'],
          'name' => page['name'],
          'current' => page['current'],
          'runes' => groupRunes,
        })
      end

      return { 'summonerId' => sumId, 'pages' => groupPages}

    elsif response.code == 404
      raise EntityNotFoundError
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def self.fetchSummonerMasteries(sumId)
    region = URID.GetRegion(sumId)
    url = "https://#{regionToPlatform(region)}.api.riotgames.com/lol/platform/v3/masteries/by-summoner/#{URID.GetId(sumId)}"
    response = HTTP.get(url, :params => { :api_key => API_KEY })

    if response.code == 200
      jsonData = response.parse

      return {
        :summonerId => sumId,
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

  def self.fetchSummonerChampionsMastery(sumId)
    region = URID.GetRegion(sumId)

    url = "https://#{regionToPlatform(region)}.api.riotgames.com/lol/champion-mastery/v3/champion-masteries/by-summoner/#{URID.GetId(sumId)}"
    response = HTTP.get(url, :params => { :api_key => API_KEY, :count => 200 })

    if response.code == 200
      return {
        :summonerId => sumId,
        :masteries => response.parse,
      }

    elsif response.code == 404
      return {
        :summonerId => sumId,
        :masteries => [],
      }
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def self.fetchSummonerStatsSummary(sumId, season = 'SEASON2017')
    region = URID.GetRegion(sumId)
    url = "https://#{regionToPlatform(region)}.api.riotgames.com/api/lol/#{region.downcase}/v1.3/stats/by-summoner/#{URID.GetId(sumId)}/summary"
    response = HTTP.get(url, :params => { :api_key => API_KEY, :season => season })

    if response.code == 200
      return {
        :summonerId => sumId,
        :season => season,
        :playerStatSummaries => response.parse['playerStatSummaries'],
      }

    elsif response.code == 404
      return {
        :summonerId => sumId,
        :season => season,
        :playerStatSummaries => [],
      }
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def self.fetchSummonerStatsRanked(sumId)
    region = URID.GetRegion(sumId)
    url = "https://#{regionToPlatform(region)}.api.riotgames.com/api/lol/#{region.downcase}/v1.3/stats/by-summoner/#{URID.GetId(sumId)}/ranked"
    response = HTTP.get(url, :params => { :api_key => API_KEY })

    if response.code == 200
      return {
        :summonerId => sumId,
        :champions => response.parse['champions'],
      }

    elsif response.code == 404
      return {
        :summonerId => sumId,
        :champions => [],
      }
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def self.fetchSummonersLeagueEntries(sumUrids)
    region = URID.GetRegion(sumUrids[0])
    sumIds = sumUrids.map { |sumId| URID.GetId(sumId) }

    url = "https://#{regionToPlatform(region)}.api.riotgames.com/api/lol/#{region.downcase}/v2.5/league/by-summoner/#{sumIds.join(',')}/entry"
    response = HTTP.get(url, :params => { :api_key => API_KEY})

    if response.code == 200
      jsonResponse = response.parse
      leagueEntries = []

      sumIds.each do |sumId|
        if jsonResponse.has_key?(sumId.to_s)
          leagueEntries.push(
            :summonerId => URID.Generate(sumId, region),
            :entries => jsonResponse[sumId.to_s],
          )
        else
          leagueEntries.push(
            :summonerId => URID.Generate(sumId, region),
            :entries => [],
          )
        end
      end

      return leagueEntries
    elsif response.code == 404
      leagueEntries = []

      sumIds.each do |sumId|
        leagueEntries.push({
            :summonerId => URID.Generate(sumId, region),
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

  def self.fetchSummonerGamesRecent(sumId)
    region = URID.GetRegion(sumId)
    url = "https://#{regionToPlatform(region)}.api.riotgames.com/api/lol/#{region.downcase}/v1.3/game/by-summoner/#{URID.GetId(sumId)}/recent"
    response = HTTP.get(url, :params => { :api_key => API_KEY})

    if response.code == 200
      jsonResponse = response.parse

      games = jsonResponse['games'].each { |game|
        game['fellowPlayers'] = game['fellowPlayers'].each { |player|
          player['summonerId'] = URID.Generate(player['summonerId'], region)
          player
        }
        game
      }
      return {
        :summonerId => sumId,
        :games => games,
      }
    elsif response.code == 404
      return {
        :summonerId => sumId,
        :games => [],
      }
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def self.fetchSummonerGameCurrent(sumId)
    region = URID.GetRegion(sumId)
    platform = regionToPlatform(region)
    url = "https://#{regionToPlatform(region)}.api.riotgames.com/observer-mode/rest/consumer/getSpectatorGameInfo/#{platform}/#{URID.GetId(sumId)}"
    response = HTTP.get(url, :params => { :api_key => API_KEY})

    if response.code == 200
      jsonResponse = response.parse

      gameData = jsonResponse
      gameData['region'] = URID.GetRegion(sumId)

      gameData['participants'] = gameData['participants'].map { |participant|
        participant['summonerId'] = URID.Generate(participant['summonerId'], region)
        participant
      }

      return gameData.symbolize_keys
    elsif response.code == 404
      raise EntityNotFoundError
    elsif response.code == 429
      raise RiotLimitReached
    else
      raise RiotServerError
    end
  end

  def self.fetchMatch(matchUrid)
    region = URID.GetRegion(matchUrid)
    matchId = URID.GetId(matchUrid)

    url = "https://#{regionToPlatform(region)}.api.riotgames.com/api/lol/#{region.downcase}/v2.2/match/#{matchId}"
    response = HTTP.get(url, :params => { :api_key => API_KEY})

    if response.code == 200
      jsonResponse = response.parse

      participants = jsonResponse['participants'].map { |participant|
        summonerData = jsonResponse['participantIdentities'].detect { |identity| identity['participantId'] == participant['participantId'] }['player']
        summonerData['summonerId'] = URID.Generate(summonerData['summonerId'], jsonResponse['region'])
        participant['summonerData'] = summonerData
        participant
      }

      return {
        :id => matchUrid,
        :queueType => jsonResponse['queueType'],
        :region => jsonResponse['region'],
        :mapId => jsonResponse['mapId'],
        :matchCreation => jsonResponse['matchCreation'],
        :matchMode => jsonResponse['matchMode'],
        :matchDuration => jsonResponse['matchDuration'],
        :matchType => jsonResponse['matchType'],
        :participants => participants,
        :teams => jsonResponse['teams'],
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
