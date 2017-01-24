class RuneSerializer < ActiveModel::Serializer
  type 'runes'
  attributes :pages

  def pages
    object.pages = object.pages.map { |page|
      page['runes'] = page['runes'].map { |rune|
        rune.merge(RiotStatic.rune(rune['runeId'], I18n.locale).slice('name', 'description', 'image'))
      }
      page
    }
  end
end
