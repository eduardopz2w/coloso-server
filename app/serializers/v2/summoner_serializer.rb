module V2
  class SummonerSerializer < ActiveModel::Serializer
    attributes :id, :name, :profileIconId, :summonerLevel, :region
  end
end
