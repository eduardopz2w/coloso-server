class SummonersController < ApplicationController
  def findByName
    region = params[:region]
    summonerName = params[:summonerName]

    riotApi = RiotApi.new(region)

    begin
      summoner = riotApi.getSummonerByName(summonerName)
      return render(json: summoner)
    rescue EntityNotFoundError
      return render(json: { :message => I18n.t('summoner_not_found') })
    end
  end

  def findById
    region = params[:region]
    summonerId = params[:summonerId]

    riotApi = RiotApi.new(region)

    begin
      summoner = riotApi.getSummonerById(summonerId)
      return render(json: summoner)
    rescue EntityNotFoundError
      return render(json: { :message => I18n.t('summoner_not_found') })
    end
  end

  def runes
    region = params[:region]
    summonerId = params[:summonerId]

    riotApi = RiotApi.new(region)

    begin
      runes = riotApi.getSummonerRunes(summonerId)
      return render(json: runes)
    rescue EntityNotFoundError
      return render(json: { :message => I18n.t('runes_not_found') })
    end
  end
end
