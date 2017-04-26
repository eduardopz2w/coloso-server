module V1
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

    def self.findSummonerStatsRanked(sumUrid, cacheMinutes = 500)
      stats = StatsRanked.find_by(:summonerUrid => sumUrid)

      if stats and self.isOutDated(stats.updated_at, cacheMinutes)
        stats = false
      end

      return stats
    end

    def self.saveSummonerStatsRanked(statsData)
      stats = StatsRanked.find_by(:summonerUrid => statsData[:summonerUrid])

      if stats
        stats.update(statsData.slice(:champions))
        stats.touch
        return stats
      else
        return StatsRanked.create(statsData)
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

    def self.findMatch(matchUrid)
      match = Match.find_by(:matchUrid => matchUrid)

      if match
        return match
      end

      return false
    end

    def self.saveMatch(matchData)
      match = Match.find_by(:matchUrid => matchData[:matchUrid])

      if match
        return match
      else
        return Match.create(matchData)
      end
    end
  end
end
