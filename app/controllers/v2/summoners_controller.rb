module V2
  class SummonersController < V1::SummonersController
    def gameCurrent
      sumUrid = params[:sumUrid]


      begin
        gameCurrent = RiotApi::Summoner.gameCurrent(sumUrid)

        return render(json: gameCurrent, serializer: GamesCurrentSerializer, focusSummonerUrid: sumUrid )
      rescue RiotLimitReached
        return render(json: { :message => I18n.t('riot_limit_error') }, status: :service_unavailable)
      rescue EntityNotFoundError
        return render(json: { :message => I18n.t('summoner_not_in_game') }, status: :not_found)
      #rescue Exception
      #  return render(json: { :message => I18n.t('riot_server_error') }, status: :service_unavailable)
      end
    end
  end
end
