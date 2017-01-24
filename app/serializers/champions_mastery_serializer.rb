class ChampionsMasterySerializer < ActiveModel::Serializer
  attributes :masteries

  def masteries
    object.masteries.each { |mastery|
      mastery['championData'] = RiotStatic.champion(mastery['championId'], I18n.locale).slice('name', 'title')
      mastery
    }
  end
end
