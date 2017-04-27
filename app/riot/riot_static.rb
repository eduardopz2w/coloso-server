module RiotStatic
  @staticJsons = {
    'en' => {
      'rune' => JSON.parse(File.read("app/assets/riot_static/en/rune.json")),
      'champion' => JSON.parse(File.read("app/assets/riot_static/en/champion.json")),
      'item' => JSON.parse(File.read("app/assets/riot_static/en/item.json")),
    },
    'es' => {
      'rune' => JSON.parse(File.read("app/assets/riot_static/es/rune.json")),
      'champion' => JSON.parse(File.read("app/assets/riot_static/es/champion.json")),
      'item' => JSON.parse(File.read("app/assets/riot_static/es/item.json")),
    }
  }

  def RiotStatic.rune(runeId, locale)
    return @staticJsons[locale.to_s]['rune']['data'][runeId.to_s]
  end

  def RiotStatic.item(itemId, locale)
    return @staticJsons[locale.to_s]['item']['data'][itemId.to_s]
  end

  def RiotStatic.champion(championId, locale = 'en')
    staticData = {}

    @staticJsons[locale.to_s]['champion']['data'].each do |champName, champData|
      if champData['key'] == championId.to_s
        staticData = champData
      end
    end

    return staticData
  end
end
