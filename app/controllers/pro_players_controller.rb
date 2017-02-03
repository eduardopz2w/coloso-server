class ProPlayersController < ApplicationController
  before_action :checkPassword, only: [:create, :destroy]

  def checkPassword
    unless BCrypt::Password.new("$2a$10$A76Y2ZOZ0gATA88SjOUK7OaZFuE6syLvOcVn/d0eS.sAPTfTVavLy") == params[:password]
      return render json: { :message => 'Contraseña incorrecta' }
    end
  end

  def index
    proPlayers = ProPlayer.all().order('name ASC')

    return render json: proPlayers
  end

  def destroy
    proPlayerId = params[:id]
    proPlayer = ProPlayer.find_by(id: proPlayerId)

    if proPlayer
      proPlayer.destroy()

      return render json: { :message => 'Pro player has been deleted '}
    else
      return render json: { :message => 'Pro player not found '}
    end
  end

  def create
    proPlayerData = params[:proPlayer].permit(:name, :imageUrl, :realName, :role).to_h
    proSummonerData = params[:proSummoner].permit(:summonerUrid).to_h

    proPlayer = ProPlayer.find_by(name: proPlayerData['name'])

    if proPlayer
      proSummoner = proPlayer.pro_summoners.create(proSummonerData)

      if proSummoner.valid?
        return render(json: { :message => 'Se ha agregado una nueva cuenta', :proPlayer => proPlayer, :proSummoner => proSummoner })
      else
        return render(json: { :message => 'Error al agregar la cuenta', :proPlayer => proPlayer, :errors => proSummoner.errors.messages })
      end
    else
      proPlayer = ProPlayer.create(proPlayerData)

      if proPlayer.valid?
        proSummoner = proPlayer.pro_summoners.create(proSummonerData)

        if proSummoner.valid?
          return render(json: { :message => 'Se ha creado un nuevo proPlayer', :proPlayer => proPlayer, :proSummoner => proSummoner })
        else
          return render(json: { :message => 'No se ha podido agregar la cuenta', :proPlayer => proPlayer, :errors => proSummoner.errors.messages })
        end
      else
        return render(json: { :message => 'No se ha podido crear el proPlayer', :errors => proPlayer.errors.messages })
      end
    end
  end
end
