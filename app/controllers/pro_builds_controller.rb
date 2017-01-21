def pagination_dict(object)
  {
    currentPage: object.current_page,
    totalPages: object.total_pages,
  }
end

class ProBuildsController < ApplicationController
  before_filter :forceJson
  # TODO: Agregar locales

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

    proBuilds = query.includes(:pro_summoner => :pro_player).paginate(:page => params[:page], :per_page => params[:pageSize]).order('matchCreation DESC')

    return render json: proBuilds, locale: 'en', meta: pagination_dict(proBuilds)
  end

  def show
    proBuild = ProBuild.find_by(id: params[:id])

    if proBuild
      return render json: proBuild, locale: 'en'
    else
      return render(json: { :message => 'Build no encontrada' }, status: :not_found )
    end

  end

  private
    def forceJson
      request.format = "json"
    end
end
