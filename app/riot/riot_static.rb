class RiotStatic
  private
    def initialize(locale)
      @locale = locale
      loadLocaleFiles()
    end

    def loadLocaleFiles()
      @runeStaticJson = JSON.parse(File.read("app/assets/riot_static/#{@locale}/rune.json"))
      @championStaticJson = JSON.parse(File.read("app/assets/riot_static/#{@locale}/champion.json"))
    end

  public
    def rune(runeId)
      return @runeStaticJson['data'][runeId.to_s]
    end

    def champion(championId)
      staticData = {}

      @championStaticJson['data'].each do |champName, champData|
        if champData['key'] == championId.to_s
          staticData = champData
        end
      end

      return staticData
    end

end
