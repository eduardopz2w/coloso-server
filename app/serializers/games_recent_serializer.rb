class GamesRecentSerializer < ActiveModel::Serializer
  type('gamesRecent')
  attributes :games
end
