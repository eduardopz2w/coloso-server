module V2
  class GamesCurrentSerializer < ActiveModel::Serializer
    type 'gamesCurrent'
    attributes :gameId, :mapId, :gameMode, :gameType, :gameQueueConfigId, :participants, :observers, :bannedChampions, :gameStartTime, :gameLength, :region

    def participants
      object.participants.map { |participant|
        participant['runes'] = participant['runes'].map { |rune|
          rune.merge(RiotStatic.rune(rune['runeId'], I18n.locale).slice('name', 'description', 'image'))
        }
        participant
      }
    end
  end
end
