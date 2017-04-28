
module RiotApi
  module Summoner
    def self.byName(sumName, region)
      summoner = RiotCache.findSummonerByName(sumName, region)

      if summoner
        return summoner
      else
        sumData = RiotClient.fetchSummonerByName(sumName, region)
        summoner = RiotCache.saveSummonerByName(sumData)
        return summoner
      end
    end

    def self.byUrid(sumUrid)
      summoner = RiotCache.findSummonerById(sumUrid)

      if summoner
        return summoner
      else
        sumData = RiotClient.fetchSummonerByUrid(sumUrid)
        summoner = RiotCache.saveSummonerById(sumData)
        return summoner
      end
    end

    def self.runes(sumId)
      runes = RiotCache.findSummonerRunes(sumId)

      if runes
        return runes
      else
        runesData = RiotClient.fetchSummonerRunes(sumId)
        runes = RiotCache.saveSummonerRunes(runesData)
        return runes
      end
    end

    def self.masteries(sumId)
      masteries = RiotCache.findSummonerMasteries(sumId)

      if masteries
        return masteries
      else
        masteriesData = RiotClient.fetchSummonerMasteries(sumId)
        masteries = RiotCache.saveSummonerMasteries(masteriesData)
        return masteries
      end
    end

    def self.championsMastery(sumId)
      masteries = RiotCache.findSummonerChampionsMastery(sumId)

      if masteries
        return masteries
      else
        masteriesData = RiotClient.fetchSummonerChampionsMastery(sumId)
        masteries = RiotCache.saveSummonerChampionsMastery(masteriesData)
        return masteries
      end
    end

    def self.statsSummary(sumId, season)
      stats = RiotCache.findSummonerStatsSummary(sumId, season)

      if stats
        return stats
      else
        statsData = RiotClient.fetchSummonerStatsSummary(sumId, season)
        stats = RiotCache.saveSummonerStatsSummary(statsData)
        return stats
      end
    end

    def self.statsRanked(sumId)
      stats = RiotCache.findSummonerStatsRanked(sumId)

      if stats
        return stats
      else
        statsData = RiotClient.fetchSummonerStatsRanked(sumId)
        stats = RiotCache.saveSummonerStatsRanked(statsData)
        return stats
      end
    end

    def self.leagueEntry(sumId)
      leagueEntries = RiotCache.findSummonersLeagueEntries([sumId])

      if leagueEntries
        return leagueEntries[0]
      else
        leagueEntriesData = RiotClient.fetchSummonersLeagueEntries([sumId])
        leagueEntries = RiotCache.saveSummonersLeagueEntries(leagueEntriesData)
        return leagueEntries[0]
      end
    end

      def self.gamesRecent(sumId)
          games = RiotCache.findSummonerGamesRecent(sumId)

          if games
            return games
          else
            gamesData = RiotClient.fetchSummonerGamesRecent(sumId)
            games = RiotCache.saveSummonerGamesRecent(gamesData)
            return games
          end
      end

      def self.gameCurrent(sumId)
        game = RiotClient.fetchSummonerGameCurrent(sumId)

        sumIds = []
        statsRanked = []

        game[:participants].each { |participant| sumIds.push(participant['summonerId'])}

        leagueEntries = RiotApi.summonersLeagueEntry(sumIds)

        sumIds.each{ |id|
          begin
            sumStats = self.statsRanked(id)
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
              participant['championRankedStats'] = championStats['stats']
            end
          end

          participant['leagueEntries'] = leagueEntries.find{ |leagueEntry| leagueEntry['summonerId'] == sumId }
        end

        return GameCurrent.new(game)
      end

  end

  module Match
    def self.byUrid(matchUrid)
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

  def self.summonersLeagueEntry(sumIds)
      leagueEntries = RiotCache.findSummonersLeagueEntries(sumIds)

      if leagueEntries
        return leagueEntries
      else
        leagueEntriesData = RiotClient.fetchSummonersLeagueEntries(sumIds)
        leagueEntries = RiotCache.saveSummonersLeagueEntries(leagueEntriesData)
        return leagueEntries
      end
  end

end
