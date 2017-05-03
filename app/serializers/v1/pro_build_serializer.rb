module V1
  class ProBuildSerializer < ActiveModel::Serializer
    attributes :id,
      :spell1Id,
      :spell2Id,
      :championId,
      :championData,
      :highestAchievedSeasonTier,
      :masteries,
      :runes,
      :stats,
      :itemsOrder,
      :skillsOrder

    attribute :gameId, key: :matchUrid
    attribute :gameCreation, key: :matchCreation

    has_one :pro_summoner

    def runes
      object.runes = object.runes.map { |rune|
        rune.merge(RiotStatic.rune(rune['runeId'], I18n.locale).slice('name', 'description', 'image'))
      }
    end

    def itemsOrder
      object.itemsOrder = object.itemsOrder.map { |item|
        item.merge(RiotStatic.item(item['itemId'], I18n.locale).slice('name', 'plaintext', 'gold'))
      }
    end

    def championData
      RiotStatic.champion(object.championId, I18n.locale).slice('name', 'title')
    end
  end
end
