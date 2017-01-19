class ProBuildsController < ApplicationController
  def index
    query = ProBuild

    if params[:championId]
      query = query.where(championId: params[:championId].to_i)
    end

    if params[:proPlayerId]
      proSummoner = ProSummoner.find_by(pro_player_id: params[:proPlayerId].to_i)

      if proSummoner
        query = query.where(pro_summoner_id: proSummoner.id)
      end
    end

    @proBuilds = query.includes(:pro_summoner => :pro_player).paginate(:page => params[:pageSize], :per_page => params[:per_page]).order('matchCreation DESC')
  end
end
