class SummonerSerializer < ActiveModel::Serializer
  attributes :urid, :name, :profileIconId, :summonerLevel, :region
end
