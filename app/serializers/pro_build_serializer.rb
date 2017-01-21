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
    :skillsOrder,
    :pro_player

  has_one :pro_summoner

  def runes
    object.runes = object.runes.map { |rune|
      rune.merge(RiotStatic.rune(rune['runeId'], instance_options[:locale]).slice('name', 'description', 'image'))
    }
  end

  def pro_player
    object.pro_summoner.pro_player
  end
end
