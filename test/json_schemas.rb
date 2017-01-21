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
    },
    'required' => ['summoner']
  }

  Runes = {
    'type' => 'object',
    'properties' => {
      'runes' => {
        'properties' => {
          'pages' => {
            'type' => 'array',
            'items' => {
              'type' => 'object',
              'properties' => {
                'id' => {
                  'type' => 'integer',
                },
                'name' => {
                  'type' => 'string',
                },
                'current' => {
                  'type' => 'boolean',
                },
                'runes' => {
                  'type' => 'array',
                  'items' => {
                    'type' => 'object',
                    'properties' => {
                      'runeId' => {
                        'type' => 'integer',
                      },
                      'count' => {
                        'type' => 'integer',
                        'minimum' => 1,
                        'maximum' => 9,
                      },
                      'name' => {
                        'type' => 'string',
                      },
                      'description' => {
                        'type' => 'string',
                      },
                      'image' => {
                        'type' => 'object',
                        'properties' => {
                          'full' => {
                            'type' => 'string',
                          },
                        },
                        'required' => ['full'],
                      },
                    },
                    'required' => ['runeId', 'count', 'name', 'description', 'image'],
                  }
                },
              },
              'required' => ['id', 'name', 'current', 'runes'],
            },
          },
        },
        'required' => ['pages'],
      },
    },
    'required' => ['runes'],
  }
end
