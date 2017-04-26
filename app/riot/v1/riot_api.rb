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

    def self.getSummonerStatsRanked(sumUrid)
        stats = RiotCache.findSummonerStatsRanked(sumUrid)

        if stats
          return stats
        else
          statsData = RiotClient.fetchSummonerStatsRanked(sumUrid)
          stats = RiotCache.saveSummonerStatsRanked(statsData)
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
      statsRanked = []

      game[:participants].each { |participant| sumUrids.push(participant['summonerUrid'])}

      leagueEntries = self.getSummonersLeagueEntry(sumUrids)

      sumUrids.each{ |urid|
        begin
          sumStats = self.getSummonerStatsRanked(urid)
          statsRanked.push(sumStats)
        rescue
          # FetchError
        end
      }

      game[:participants].each do |participant|
        sumUrid = participant['summonerUrid']
        participantRankedStats = statsRanked.find{ |stat|  stat[:summonerUrid] == sumUrid }

        if participantRankedStats
          championStats = participantRankedStats[:champions].find{ |champion| champion['id'] == participant['championId'] }

          if championStats
            participant[:championRankedStats] = championStats['stats']
          end
        end

        participant[:leagueEntry] = leagueEntries.find{ |leagueEntry| leagueEntry['summonerUrid'] == sumUrid }
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
