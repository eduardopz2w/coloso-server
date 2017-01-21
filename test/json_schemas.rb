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

  Masteries = {
    'type' => 'object',
    'properties' => {
      'masteries' => {
        'type' => 'object',
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
                'masteries' => {
                  'type' => 'array',
                  'items' => {
                    'type' => 'object',
                    'properties' => {
                      'id' => {
                        'type' => 'integer',
                      },
                      'rank' => {
                        'type' => 'integer',
                        'minimum' => 1,
                        'maximum' => 5,
                      },
                    },
                    'required' => ['id', 'rank'],
                  },
                },
              },
              'required' => ['id', 'name', 'current', 'masteries'],
            },
          },
        },
        'required' => ['pages'],
      }
    },
    'required' => ['masteries']
  }

  StatsSummary = {
    'type' => 'object',
    'properties' => {
      'statsSummary' => {
        'type' => 'object',
        'properties' => {
          'playerStatSummaries' => {
            'type' => 'array',
          },
        },
        'required' => ['playerStatSummaries'],
      },
    },
    'required' => ['statsSummary'],
  }

  ChampionsMastery = {
    'type' => 'object',
    'properties' => {
      'championsMastery' => {
        'type' => 'object',
        'properties' => {
          'masteries' => {
            'type' => 'array',
            'items' => {
            'type' => 'object',
            'properties' => {
              'championId' => {
                'type' => 'integer',
              },
              'championLevel' => {
                'type' => 'integer',
              },
              'championPoints' => {
                'type' => 'integer',
              },
              'lastPlayTime' => {
                'type' => 'integer',
              },
              'chestGranted' => {
                'type' => 'boolean',
              },
              'tokensEarned' => {
                'type' => 'integer',
              },
              'championData' => {
                'type' => 'object',
                'properties' => {
                  'name' => {
                    'type' => 'string',
                  },
                  'title' => {
                    'type' => 'string',
                  },
                },
                'required' => ['name', 'title'],
              },
            },
            'required' => ['championId', 'championLevel', 'championPoints', 'lastPlayTime', 'chestGranted', 'tokensEarned', 'championData'],
          },
          }
        },
        'required' => ['masteries'],
      }
    },
    'required' => ['championsMastery'],
  }
end
