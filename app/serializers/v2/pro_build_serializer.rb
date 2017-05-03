module V2
  class ProBuildSerializer < ActiveModel::Serializer
    attributes :id,
      :gameCreation,
      :gameId,
      :seasonId,
      :queueId,
      :gameMode,
      :gameVersion,
      :platformId,
      :mapId,
      :gameType,
      :gameDuration,
      :spell1Id,
      :spell2Id,
      :championId,
      :highestAchievedSeasonTier,
      :masteries,
      :runes,
      :stats,
      :itemsOrder,
      :skillsOrder,
      :champion

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

    def champion
      championData = RiotStatic.champion(object.championId, I18n.locale).slice('name', 'title')
      return {
        :id => object.championId,
        :name => championData['name'],
        :title => championData['title']
      }
    end
  end
end
