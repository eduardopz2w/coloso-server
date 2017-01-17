class ProPlayersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    proPlayers = ProPlayer.includes(:pro_summoner).all

    return render(:json => { :proPlayers => proPlayers})
  end

  def create
    proPlayer = ProPlayer.create(
      :name => params[:name],
      :imageUrl => params[:imageUrl],
      :realName => params[:realName],
      :role => params[:role]
    )

    if proPlayer
      proPlayer.create_pro_summoner(:summonerId => params[:summonerId], :region => params[:region])

      return render(json: proPlayer.to_json(:include => :pro_summoner))
    else
      return render(json: { message: 'Error al guardar' })
    end
  end
end
