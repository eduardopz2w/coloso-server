class ProPlayersController < ApplicationController
  def index
    proPlayers = ProPlayer.includes(:pro_summoner).all

    return render json: proPlayers
  end
end
