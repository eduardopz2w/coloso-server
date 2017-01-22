class ProBuildSerializer < ActiveModel::Serializer
  type 'proBuild'

  attributes :id,
    :matchId,
    :matchCreation,
    :region,
    :spell1Id,
    :spell2Id,
    :championId,
    :highestAchievedSeasonTier,
    :masteries,
    :runes,
    :stats,
    :itemsOrder,
    :skillsOrder

  has_one :pro_summoner

  def runes
    object.runes = object.runes.map { |rune|
      rune.merge(RiotStatic.rune(rune['runeId'], instance_options[:locale]).slice('name', 'description', 'image'))
    }
  end

  def itemsOrder
    object.itemsOrder = object.itemsOrder.map { |item|
      item.merge(RiotStatic.item(item['itemId'], instance_options[:locale]).slice('name', 'plaintext', 'gold'))
    }
  end
end
