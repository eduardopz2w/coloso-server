class SummonerSerializer < ActiveModel::Serializer
  attributes :summonerId, :name, :profileIconId, :summonerLevel, :region
end
