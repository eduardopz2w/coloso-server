class SummonerSerializer < ActiveModel::Serializer
  attributes :summonerId, :profileIconId, :summonerLevel, :region
end
