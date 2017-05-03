module V1
  class SummonerSerializer < ActiveModel::Serializer
    attributes :urid, :name, :profileIconId, :summonerLevel, :region

    def urid
      object.id
    end
  end
end
