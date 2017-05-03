module V1
  class GamesRecentSerializer < ActiveModel::Serializer
    type('gamesRecent')
    attributes :games
  end
end
