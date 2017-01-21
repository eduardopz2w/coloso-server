module JSON_SCHEMAS
  Summoner = {
    'type' => 'object',
    'properties' => {
      'summoner' => {
        'type' => 'object',
        'properties' => {
          'summonerId' => {
            'type' => 'integer',
          },
          'name' => {
            'type' => 'string',
          },
          'profileIconId' => {
            'type' => 'integer',
          },
          'summonerLevel' => {
            'type' => 'integer',
          },
          'region' => {
            'type' => 'string',
            'enum' => ['br', 'eune', 'euw', 'jp', 'kr', 'lan', 'las', 'na', 'oce', 'ru'],
          },
        },
        'required' => ['summonerId', 'name', 'profileIconId', 'summonerLevel', 'region']
      }
    }
  }
end
