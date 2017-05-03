module V1
  class ProSummonerSerializer < ActiveModel::Serializer
    attributes :id, :summonerUrid

    has_one :pro_player

    def summonerUrid
      object.summonerId
    end
  end
end
