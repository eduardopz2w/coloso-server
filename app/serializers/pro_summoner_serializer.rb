class ProSummonerSerializer < ActiveModel::Serializer
  attributes :id, :summonerUrid, :region

  has_one :pro_player
end
