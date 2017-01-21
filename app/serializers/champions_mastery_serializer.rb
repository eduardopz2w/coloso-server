class ChampionsMasterySerializer < ActiveModel::Serializer
  type 'championsMasteries'

  attributes :masteries

  def masteries
    object.masteries.each { |mastery|
      mastery['championData'] = RiotStatic.champion(mastery['championId'], instance_options[:locale]).slice('name', 'title')
      mastery
    }
  end
end
