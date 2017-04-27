module V2
  class GamesRecentSerializer < ActiveModel::Serializer
    type('gamesRecent')
    attributes :games
  end
end
