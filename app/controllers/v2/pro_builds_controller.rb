def pagination_dict(object)
  {
    currentPage: object.current_page,
    totalPages: object.total_pages,
  }
end

module V2
  class ProBuildsController < V1::ProBuildsController
    def index
      query = ProBuild
      pageNumber = params[:page] && params[:page]['number'] || 1
      pageSize = params[:page] && params[:page]['size'] || 25

      if params[:championId]
        query = query.where(championId: params[:championId].to_i)
      end

      if params[:proPlayerId]
        proSummoner = ProSummoner.find_by(pro_player_id: params[:proPlayerId].to_i)

        if proSummoner
          query = query.where(pro_summoner_id: proSummoner.id)
        end
      end

      if params[:ids]
        query = query.where(id: params[:ids].split(','))
      end

      proBuilds = query.includes(:pro_summoner => :pro_player).order('(gameCreation + (gameDuration * 1000)) DESC').paginate(:page => pageNumber, :per_page => pageSize)

      return render(json: proBuilds, meta: pagination_dict(proBuilds), include: '**')
    end
  end
end
