module V2
  class MatchSerializer < ActiveModel::Serializer
    type 'games'

    attributes :id,
      :queueType,
      :mapId,
      :gameCreation,
      :gameMode,
      :gameDuration,
      :gameType,
      :teams,
      :participants,
      :seasonId,
      :queueId,
      :gameVersion,
      :platformId

    def participants
      object.participants.map { |participant|
        participant['runes'] = participant['runes'].map { |rune|
          rune.merge(RiotStatic.rune(rune['runeId'], I18n.locale).slice('name', 'description', 'image'))
        }
        participant['champion'] = RiotStatic.champion(participant['championId'], I18n.locale).slice('name', 'title')
        participant
      }
    end
  end
end
