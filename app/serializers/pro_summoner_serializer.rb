class ProSummonerSerializer < ActiveModel::Serializer
  attributes :id, :summonerUrid

  has_one :pro_player
end
