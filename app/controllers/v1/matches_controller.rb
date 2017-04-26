module V1
  class MatchesController < ApplicationController
    def show
      matchUrid = params[:matchUrid]

      begin
        match = RiotApi.getMatch(matchUrid)
        return render(json: match)
      rescue RiotLimitReached
        return render(json: { :message => I18n.t('riot_limit_error') }, status: :service_unavailable)
      rescue EntityNotFoundError
        return render(json: { :message => I18n.t('match_not_found') }, status: :not_found)
      rescue
        return render(json: { :message => I18n.t('riot_server_error') }, status: :service_unavailable)
      end
    end
  end
end
