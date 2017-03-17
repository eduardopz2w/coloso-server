class MatchSerializer < ActiveModel::Serializer
  attributes :matchUrid,
    :queueType,
    :region,
    :mapId,
    :matchCreation,
    :matchMode,
    :matchDuration,
    :matchType,
    :teams,
    :participants

  def participants
    object.participants.map { |participant|
      participant['runes'] = participant['runes'].map { |rune|
        rune.merge(RiotStatic.rune(rune['runeId'], I18n.locale).slice('name', 'description', 'image'))
      }
      participant['championData'] = RiotStatic.champion(participant['championId'], I18n.locale).slice('name', 'title')
      participant
    }
  end
end
