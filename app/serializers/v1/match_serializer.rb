module V1
  class MatchSerializer < ActiveModel::Serializer
    attributes :teams,
      :participants

    attribute :id, key: :matchUrid
    attribute :gameType, key: :matchType
    attribute :gameCreation, key: :matchCreation
    attribute :gameMode, key: :matchMode
    attribute :gameDuration, key: :matchDuration

    def participants
      object.participants.map { |participant|
        participant['runes'] = participant['runes'].map { |rune|
          rune.merge(RiotStatic.rune(rune['runeId'], I18n.locale).slice('name', 'description', 'image'))
        }
        participant['championData'] = RiotStatic.champion(participant['championId'], I18n.locale).slice('name', 'title')
        participant['summonerData'] = participant['summoner']
        participant.delete('summoner')
        participant['summonerData']['summonerUrid'] = participant['summonerData']['summonerId']
        participant['summonerData'].delete('summonerId')
        participant['stats']['minionsKilled'] = participant['stats']['totalMinionsKilled']
        participant
      }
    end

    def teams
      object.teams.map { |team|
        team["winner"] = team["win"] == "Win" ? true : false
        team
      }
    end

    def matchUrid
      object.id
    end
  end
end
