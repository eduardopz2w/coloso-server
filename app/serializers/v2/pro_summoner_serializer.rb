module V2
  class ProSummonerSerializer < ActiveModel::Serializer
    attributes :id, :summonerId

    has_one :pro_player
  end
end
