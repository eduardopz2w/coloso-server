module V1
  class GamesCurrentSerializer < ActiveModel::Serializer
    type 'gamesCurrent'
    attributes :gameId, :mapId, :gameMode, :gameType, :gameQueueConfigId, :participants, :observers, :bannedChampions, :gameStartTime, :gameLength, :focusSummonerUrid, :region

    def focusSummonerUrid
      instance_options[:focusSummonerUrid]
    end

    def participants
      object.participants.map { |participant|
        participant['runes'] = participant['runes'].map { |rune|
          rune.merge(RiotStatic.rune(rune['runeId'], I18n.locale).slice('name', 'description', 'image'))
        }
        participant['leagueEntry'] = participant['leagueEntries'] || nil
        participant.delete('leagueEntries')
        participant['summonerUrid'] = participant['summonerId']
        participant.delete('summonerId')
        participant
      }
    end
  end
end
