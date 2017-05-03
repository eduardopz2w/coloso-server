module V2
  class SummonerSerializer < ActiveModel::Serializer
    attributes :id, :accountId, :name, :profileIconId, :summonerLevel, :region
  end
end
