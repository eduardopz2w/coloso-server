module V1
  class SummonersController < ApplicationController
    def findByName
      region = params[:region]
      summonerName = params[:summonerName]

      begin
        summoner = RiotApi::Summoner.byName(summonerName, region)
        return render(json: summoner)
      rescue RiotLimitReached
        return render(json: { :message => I18n.t('riot_limit_error') }, status: :service_unavailable)
      rescue EntityNotFoundError
        return render(json: { :message => I18n.t('summoner_not_found') }, status: :not_found)
      rescue
        return render(json: { :message => I18n.t('riot_server_error') }, status: :service_unavailable)
      end
    end

    def findByUrid
      sumUrid = params[:sumUrid]


      begin
        summoner = RiotApi::Summoner.byUrid(sumUrid)
        return render(json: summoner)
      rescue RiotLimitReached
        return render(json: { :message => I18n.t('riot_limit_error') }, status: :service_unavailable)
      rescue EntityNotFoundError
        return render(json: { :message => I18n.t('summoner_not_found') }, status: :not_found)
      rescue
        return render(json: { :message => I18n.t('riot_server_error') }, status: :service_unavailable)
      end
    end

    def runes
      sumUrid = params[:sumUrid]

      begin
        runes = RiotApi::Summoner.runes(sumUrid)
        return render(json: runes)
      rescue RiotLimitReached
        return render(json: { :message => I18n.t('riot_limit_error') }, status: :service_unavailable)
      rescue EntityNotFoundError
        return render(json: { :message => I18n.t('runes_not_found') }, status: :not_found)
      rescue
        return render(json: { :message => I18n.t('riot_server_error') }, status: :service_unavailable)
      end
    end

    def masteries
      sumUrid = params[:sumUrid]


      begin
        masteries = RiotApi::Summoner.masteries(sumUrid)
        return render(json: masteries)
      rescue RiotLimitReached
        return render(json: { :message => I18n.t('riot_limit_error') }, status: :service_unavailable)
      rescue EntityNotFoundError
        return render(json: { :message => I18n.t('masteries_not_found') }, status: :not_found)
      rescue
        return render(json: { :message => I18n.t('riot_server_error') }, status: :service_unavailable)
      end
    end

    def championsMastery
      sumUrid = params[:sumUrid]


      begin
        masteries = RiotApi::Summoner.championsMastery(sumUrid)
        return render(json: masteries)
      rescue RiotLimitReached
        return render(json: { :message => I18n.t('riot_limit_error') }, status: :service_unavailable)
      rescue
        return render(json: { :message => I18n.t('riot_server_error') }, status: :service_unavailable)
      end
    end

    def statsSummary
      sumUrid = params[:sumUrid]
      season = params[:season] || 'SEASON2017'


      begin
        stats = RiotApi::Summoner.statsSummary(sumUrid, season)
        return render(json: stats)
      rescue RiotLimitReached
        return render(json: { :message => I18n.t('riot_limit_error') }, status: :service_unavailable)
      rescue
        return render(json: { :message => I18n.t('riot_server_error') }, status: :service_unavailable)
      end
    end

    def leagueEntry
      sumUrid = params[:sumUrid]

      begin
        leagueEntry = RiotApi::Summoner.leagueEntry(sumUrid)
        return render(json: leagueEntry)
      rescue RiotLimitReached
        return render(json: { :message => I18n.t('riot_limit_error') }, status: :service_unavailable)
      rescue
        return render(json: { :message => I18n.t('riot_server_error') }, status: :service_unavailable)
      end
    end

    def gamesRecent
      sumUrid = params[:sumUrid]


      begin
        games = RiotApi::Summoner.gamesRecent(sumUrid)
        return render(json: games)
      rescue RiotLimitReached
        return render(json: { :message => I18n.t('riot_limit_error') }, status: :service_unavailable)
      rescue
        return render(json: { :message => I18n.t('riot_server_error') }, status: :service_unavailable)
      end
    end

    def gameCurrent
      sumUrid = params[:sumUrid]


      begin
        gameCurrent = RiotApi::Summoner.gameCurrent(sumUrid)

        return render(json: gameCurrent, serializer: GamesCurrentSerializer, focusSummonerUrid: sumUrid )
      rescue RiotLimitReached
        return render(json: { :message => I18n.t('riot_limit_error') }, status: :service_unavailable)
      rescue EntityNotFoundError
        return render(json: { :message => I18n.t('summoner_not_in_game') }, status: :not_found)
      rescue Exception => e
       return render(json: { :message => I18n.t('riot_server_error') }, status: :service_unavailable)
      end
    end
  end
end
