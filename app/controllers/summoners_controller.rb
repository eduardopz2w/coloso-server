# TODO: Add riot server error
class SummonersController < ApplicationController
  def findByName
    region = params[:region]
    summonerName = params[:summonerName]

    riotApi = RiotApi.new(region)

    begin
      summoner = riotApi.getSummonerByName(summonerName)
      return render(json: summoner)
    rescue RiotLimitReached
      return render(json: { :message => I18n.t('riot_limit_error') })
    rescue EntityNotFoundError
      return render(json: { :message => I18n.t('summoner_not_found') }, status: :not_found)
    rescue RiotServerError
      return render(json: { :message => I18n.t('riot_server_error') })
    end
  end

  def findById
    region = params[:region]
    summonerId = params[:summonerId]

    riotApi = RiotApi.new(region)

    begin
      summoner = riotApi.getSummonerById(summonerId)
      return render(json: summoner)
    rescue RiotLimitReached
      return render(json: { :message => I18n.t('riot_limit_error') })
    rescue EntityNotFoundError
      return render(json: { :message => I18n.t('summoner_not_found') }, status: :not_found)
    rescue RiotServerError
      return render(json: { :message => I18n.t('riot_server_error') })
    end
  end

  def runes
    region = params[:region]
    summonerId = params[:summonerId]
    riotApi = RiotApi.new(region)

    begin
      runes = riotApi.getSummonerRunes(summonerId)
      return render(json: runes, locale: 'en')
    rescue RiotLimitReached
      return render(json: { :message => I18n.t('riot_limit_error') })
    rescue EntityNotFoundError
      return render(json: { :message => I18n.t('runes_not_found') }, status: :not_found)
    rescue RiotServerError
      return render(json: { :message => I18n.t('riot_server_error') })
    end
  end

  def masteries
    region = params[:region]
    summonerId = params[:summonerId]

    riotApi = RiotApi.new(region)

    begin
      masteries = riotApi.getSummonerMasteries(summonerId)
      return render(json: masteries)
    rescue RiotLimitReached
      return render(json: { :message => I18n.t('riot_limit_error') })
    rescue EntityNotFoundError
      return render(json: { :message => I18n.t('masteries_not_found') }, status: :not_found)
    rescue RiotServerError
      return render(json: { :message => I18n.t('riot_server_error') })
    end
  end

  def championsMastery
    region = params[:region]
    summonerId = params[:summonerId]

    riotApi = RiotApi.new(region)

    begin
      masteries = riotApi.getSummonerChampionsMastery(summonerId)
      return render(json: masteries, locale: 'en')
    rescue RiotLimitReached
      return render(json: { :message => I18n.t('riot_limit_error') })
    end
  end

  def statsSummary
    region = params[:region]
    summonerId = params[:summonerId]
    season = params[:season]

    riotApi = RiotApi.new(region)

    begin
      stats = riotApi.getSummonerStatsSummary(summonerId, season)
      return render(json: stats)
    rescue RiotLimitReached
      return render(json: { :message => I18n.t('riot_limit_error') })
    rescue RiotServerError
      return render(json: { :message => I18n.t('riot_server_error') })
    end
  end

  def leagueEntry
    region = params[:region]
    summonerId = params[:summonerId].to_i

    riotApi = RiotApi.new(region)

    begin
      leagueEntry = riotApi.getSummonerLeagueEntry(summonerId)
      return render(json: leagueEntry)
    rescue RiotLimitReached
      return render(json: { :message => I18n.t('riot_limit_error') })
    rescue RiotServerError
      return render(json: { :message => I18n.t('riot_server_error') })
    end
  end

  def gamesRecent
    region = params[:region]
    summonerId = params[:summonerId].to_i

    riotApi = RiotApi.new(region)

    begin
      games = riotApi.getSummonerGamesRecent(summonerId)
      return render(json: games)
    rescue RiotLimitReached
      return render(json: { :message => I18n.t('riot_limit_error') })
    rescue EntityNotFoundError
      return render(json: { :message => I18n.t('games_not_found') }, status: :not_found)
    rescue RiotServerError
      return render(json: { :message => I18n.t('riot_server_error') })
    end
  end

  def gameCurrent
    region = params[:region]
    summonerId = params[:summonerId].to_i

    riotApi = RiotApi.new(region)

    begin
      games = riotApi.getSummonerGameCurrent(summonerId)

      games['participants'] = games['participants'].map { |participant|
        participant['runes'] = participant['runes'].map { |rune|
          rune.merge(RiotStatic.rune(rune['runeId'], 'en').slice('name', 'description', 'image'))
        }
        participant
      }
      return render(json: games)
    rescue RiotLimitReached
      return render(json: { :message => I18n.t('riot_limit_error') })
    rescue EntityNotFoundError
      return render(json: { :message => I18n.t('summoner_not_in_game') }, status: :not_found)
    rescue RiotServerError
      return render(json: { :message => I18n.t('riot_server_error') })
    end
  end
end
