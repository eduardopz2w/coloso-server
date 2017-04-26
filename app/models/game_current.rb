class GameCurrent
  alias :read_attribute_for_serialization :send
  attr_accessor :id, :gameId, :mapId, :gameMode, :gameType, :gameQueueConfigId, :participants, :observers, :platformId, :bannedChampions, :gameStartTime, :gameLength, :region

  def initialize(attributes)
    @gameId = attributes[:gameId]
    @id = @gameId
    @mapId = attributes[:mapId]
    @gameMode = attributes[:gameMode]
    @gameType = attributes[:gameType]
    @gameQueueConfigId = attributes[:gameQueueConfigId]
    @participants = attributes[:participants]
    @observers = attributes[:observers]
    @platformId = attributes[:platformId]
    @bannedChampions = attributes[:bannedChampions]
    @gameStartTime = attributes[:gameStartTime]
    @gameLength = attributes[:gameLength]
    @region = attributes[:region]
  end

  def self.model_name
    @_model_name ||= ActiveModel::Name.new(self)
  end
end
