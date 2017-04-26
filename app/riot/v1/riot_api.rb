module V1
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

    def self.getSummonerById(sumId)
        summoner = RiotCache.findSummonerById(sumId)

        if summoner
          return summoner
        else
          sumData = RiotClient.fetchSummonerByUrid(sumId)
          summoner = RiotCache.saveSummonerById(sumData)
          return summoner
        end
    end

    def self.getSummonerRunes(sumId)
        runes = RiotCache.findSummonerRunes(sumId)

        if runes
          return runes
        else
          runesData = RiotClient.fetchSummonerRunes(sumId)
          runes = RiotCache.saveSummonerRunes(runesData)
          return runes
        end
    end

    def self.getSummonerMasteries(sumId)
        masteries = RiotCache.findSummonerMasteries(sumId)

        if masteries
          return masteries
        else
          masteriesData = RiotClient.fetchSummonerMasteries(sumId)
          masteries = RiotCache.saveSummonerMasteries(masteriesData)
          return masteries
        end
    end

    def self.getSummonerChampionsMastery(sumId)
        masteries = RiotCache.findSummonerChampionsMastery(sumId)

        if masteries
          return masteries
        else
          masteriesData = RiotClient.fetchSummonerChampionsMastery(sumId)
          masteries = RiotCache.saveSummonerChampionsMastery(masteriesData)
          return masteries
        end
    end

    def self.getSummonerStatsSummary(sumId, season)
        stats = RiotCache.findSummonerStatsSummary(sumId, season)

        if stats
          return stats
        else
          statsData = RiotClient.fetchSummonerStatsSummary(sumId, season)
          stats = RiotCache.saveSummonerStatsSummary(statsData)
          return stats
        end
    end

    def self.getSummonerStatsRanked(sumId)
        stats = RiotCache.findSummonerStatsRanked(sumId)

        if stats
          return stats
        else
          statsData = RiotClient.fetchSummonerStatsRanked(sumId)
          stats = RiotCache.saveSummonerStatsRanked(statsData)
          return stats
        end
    end

    def self.getSummonerLeagueEntry(sumId)
        leagueEntries = RiotCache.findSummonersLeagueEntries([sumId])

        if leagueEntries
          return leagueEntries[0]
        else
          leagueEntriesData = RiotClient.fetchSummonersLeagueEntries([sumId])
          leagueEntries = RiotCache.saveSummonersLeagueEntries(leagueEntriesData)
          return leagueEntries[0]
        end
    end

    def self.getSummonersLeagueEntry(sumIds)
        leagueEntries = RiotCache.findSummonersLeagueEntries(sumIds)

        if leagueEntries
          return leagueEntries
        else
          leagueEntriesData = RiotClient.fetchSummonersLeagueEntries(sumIds)
          leagueEntries = RiotCache.saveSummonersLeagueEntries(leagueEntriesData)
          return leagueEntries
        end
    end

    def self.getSummonerGamesRecent(sumId)
        games = RiotCache.findSummonerGamesRecent(sumId)

        if games
          return games
        else
          gamesData = RiotClient.fetchSummonerGamesRecent(sumId)
          games = RiotCache.saveSummonerGamesRecent(gamesData)
          return games
        end
    end

    def self.getSummonerGameCurrent(sumId)
      game = RiotClient.fetchSummonerGameCurrent(sumId)

      sumIds = []
      statsRanked = []

      game[:participants].each { |participant| sumIds.push(participant['summonerId'])}

      leagueEntries = self.getSummonersLeagueEntry(sumIds)

      sumIds.each{ |id|
        begin
          sumStats = self.getSummonerStatsRanked(id)
          statsRanked.push(sumStats)
        rescue
          # FetchError
        end
      }

      game[:participants].each do |participant|
        sumId = participant['summonerId']
        participantRankedStats = statsRanked.find{ |stat|  stat[:summonerId] == sumId }

        if participantRankedStats
          championStats = participantRankedStats[:champions].find{ |champion| champion['id'] == participant['championId'] }

          if championStats
            participant[:championRankedStats] = championStats['stats']
          end
        end

        participant[:leagueEntry] = leagueEntries.find{ |leagueEntry| leagueEntry['summonerId'] == sumId }
      end

      return GameCurrent.new(game)
    end

    def self.getMatch(matchUrid)
        match = RiotCache.findMatch(matchUrid)

        if match
          return match
        else
          matchData = RiotClient.fetchMatch(matchUrid)
          match = RiotCache.saveMatch(matchData)
          return match
        end
    end
  end
end
