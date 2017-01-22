class ProSummonerSerializer < ActiveModel::Serializer
  attributes :id, :summonerId, :region

  has_one :pro_player
end
