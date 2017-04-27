module V1
  class ProPlayersController < ApplicationController
    def index
      proPlayers = ProPlayer.all().order('name ASC')

      return render(json: proPlayers)
    end
  end
end
