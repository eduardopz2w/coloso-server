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
end
