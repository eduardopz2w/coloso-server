module V2
  class ProSummonerSerializer < ActiveModel::Serializer
    attributes :id

    has_one :pro_player
  end
end
