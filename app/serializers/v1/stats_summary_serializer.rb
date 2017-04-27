module V1
  class StatsSummarySerializer < ActiveModel::Serializer
    attributes :playerStatSummaries, :season
  end
end
