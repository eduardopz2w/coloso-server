module JSON_SCHEMAS
  Summoner = {
    'type': 'object',
    'properties': {
      'id': {
        'type': 'string',
      },
      'type': {
        'type': 'string',
      },
      'attributes': {
        'type': 'object',
        'properties': {
          'summonerId': {
            'type': 'integer',
          },
          'name': {
            'type': 'string',
          },
          'profileIconId': {
            'type': 'integer',
          },
          'summonerLevel': {
            'type': 'integer',
          },
          'region': {
            'type': 'string',
          },
        },
        'required': ['summonerId', 'name', 'profileIconId', 'summonerLevel', 'region']
      },
      'required': ['id', 'type'],
    },
  }

  Runes = {
    'type': 'object',
    'properties': {
      'id': { 'type': 'string' },
      'type': { 'type': 'string' },
      'attributes': {
        'type': 'object',
        'properties': {
          'pages': {
            'type': 'array',
            'items': {
              'type': 'object',
              'properties': {
                'id': {
                  'type': 'integer',
                },
                'name': {
                  'type': 'string',
                },
                'current': {
                  'type': 'boolean',
                },
                'runes': {
                  'type': 'array',
                  'items': {
                    'type': 'object',
                    'properties': {
                      'runeId': {
                        'type': 'integer',
                      },
                      'count': {
                        'type': 'integer',
                        'minimum': 1,
                        'maximum': 9,
                      },
                      'name': {
                        'type': 'string',
                      },
                      'description': {
                        'type': 'string',
                      },
                      'image': {
                        'type': 'object',
                        'properties': {
                          'full': {
                            'type': 'string',
                          },
                        },
                        'required': ['full'],
                      },
                    },
                    'required': ['runeId', 'count', 'name', 'description', 'image'],
                  }
                },
              },
              'required': ['id', 'name', 'current', 'runes'],
            },
          },
        },
        'required': ['pages'],
      },
    },
    'required': ['id', 'type', 'attributes'],
  }

  Masteries = {
    'type': 'object',
    'properties': {
      'id': { 'type': 'string' },
      'type': { 'type': 'string' },
      'attributes': {
        'type': 'object',
        'properties': {
          'pages': {
            'type': 'array',
            'items': {
              'type': 'object',
              'properties': {
                'id': {
                  'type': 'integer',
                },
                'name': {
                  'type': 'string',
                },
                'current': {
                  'type': 'boolean',
                },
                'masteries': {
                  'type': 'array',
                  'items': {
                    'type': 'object',
                    'properties': {
                      'id': {
                        'type': 'integer',
                      },
                      'rank': {
                        'type': 'integer',
                        'minimum': 1,
                        'maximum': 5,
                      },
                    },
                    'required': ['id', 'rank'],
                  },
                },
              },
              'required': ['id', 'name', 'current', 'masteries'],
            },
          },
        },
        'required': ['pages'],
      }
    },
    'required': ['id', 'type', 'attributes']
  }

  StatsSummary = {
    'type': 'object',
    'properties': {
      'id': { 'type': 'string' },
      'type': { 'type': 'string' },
      'attributes': {
        'type': 'object',
        'properties': {
          'playerStatSummaries': {
            'type': 'array',
          },
        },
        'required': ['playerStatSummaries'],
      },
    },
    'required': ['id', 'type', 'attributes'],
  }

  ChampionsMastery = {
    'type': 'object',
    'properties': {
      'id': { 'type': 'string' },
      'type': { 'type': 'string' },
      'attributes': {
        'type': 'object',
        'properties': {
          'masteries': {
            'type': 'array',
            'items': {
            'type': 'object',
            'properties': {
              'championId': {
                'type': 'integer',
              },
              'championLevel': {
                'type': 'integer',
              },
              'championPoints': {
                'type': 'integer',
              },
              'lastPlayTime': {
                'type': 'integer',
              },
              'chestGranted': {
                'type': 'boolean',
              },
              'tokensEarned': {
                'type': 'integer',
              },
              'championData': {
                'type': 'object',
                'properties': {
                  'name': {
                    'type': 'string',
                  },
                  'title': {
                    'type': 'string',
                  },
                },
                'required': ['name', 'title'],
              },
            },
            'required': ['championId', 'championLevel', 'championPoints', 'lastPlayTime', 'chestGranted', 'tokensEarned', 'championData'],
          },
          }
        },
        'required': ['masteries'],
      }
    },
    'required': ['id', 'type', 'attributes'],
  }

  GamesRecent = {
    'type': 'object',
    'properties': {
      'id': { 'type': 'string' },
      'type': { 'type': 'string' },
      'attributes': {
        'type': 'object',
        'properties': {
          'games': {
            'type': 'array',
            'items': {
              'type': 'object',
              'properties': {
                'gameId': {
                  'type': 'integer',
                },
                'invalid': {
                  'type': 'boolean',
                },
                'gameMode': {
                  'type': 'string',
                },
                'gameType': {
                  'type': 'string',
                },
                'subType': {
                  'type': 'string',
                },
                'mapId': {
                  'type': 'integer',
                },
                'teamId': {
                  'type': 'integer',
                },
                'championId': {
                  'type': 'integer',
                },
                'spell1': {
                  'type': 'integer',
                },
                'spell2': {
                  'type': 'integer',
                },
                'level': {
                  'type': 'integer',
                },
                'ipEarned': {
                  'type': 'integer',
                },
                'createDate': {
                  'type': 'integer',
                },
                'fellowPlayers': {
                  'type': 'array',
                  'items': {
                    'type': 'object',
                    'properties': {
                      'summonerId': {
                        'type': 'integer',
                      },
                      'teamId': {
                        'type': 'integer',
                      },
                      'championId': {
                        'type': 'integer',
                      },
                    }
                  }
                },
                'stats': {
                'type': 'object',
                'properties': {
                  'level': {
                    'type': 'integer',
                  },
                  'goldEarned': {
                    'type': 'integer',
                  },
                  'numDeaths': {
                    'type': 'integer',
                  },
                  'minionsKilled': {
                    'type': 'integer',
                  },
                  'championsKilled': {
                    'type': 'integer',
                  },
                  'goldSpent': {
                    'type': 'integer',
                  },
                  'totalDamageDealt': {
                    'type': 'integer',
                  },
                  'totalDamageTaken': {
                    'type': 'integer',
                  },
                  'killingSprees': {
                    'type': 'integer',
                  },
                  'largestKillingSpree': {
                    'type': 'integer',
                  },
                  'win': {
                    'type': 'boolean',
                  },
                  'neutralMinionsKilled': {
                    'type': 'integer',
                  },
                  'largestMultiKill': {
                    'type': 'integer',
                  },
                  'physicalDamageDealtPlayer': {
                    'type': 'integer',
                  },
                  'magicDamageDealtPlayer': {
                    'type': 'integer',
                  },
                  'physicalDamageTaken': {
                    'type': 'integer',
                  },
                  'magicDamageTaken': {
                    'type': 'integer',
                  },
                  'timePlayed': {
                    'type': 'integer',
                  },
                  'totalHeal': {
                    'type': 'integer',
                  },
                  'totalUnitsHealed': {
                    'type': 'integer',
                  },
                  'assists': {
                    'type': 'integer',
                  },
                  'item0': {
                    'type': 'integer',
                  },
                  'item1': {
                    'type': 'integer',
                  },
                  'item2': {
                    'type': 'integer',
                  },
                  'item3': {
                    'type': 'integer',
                  },
                  'item4': {
                    'type': 'integer',
                  },
                  'item5': {
                    'type': 'integer',
                  },
                  'item6': {
                    'type': 'integer',
                  },
                  'magicDamageDealtToChampions': {
                    'type': 'integer',
                  },
                  'physicalDamageDealtToChampions': {
                    'type': 'integer',
                  },
                  'totalDamageDealtToChampions': {
                    'type': 'integer',
                  },
                  'trueDamageDealtPlayer': {
                    'type': 'integer',
                  },
                  'trueDamageDealtToChampions': {
                    'type': 'integer',
                  },
                  'wardPlaced': {
                    'type': 'integer',
                  },
                  'neutralMinionsKilledEnemyJungle': {
                    'type': 'integer',
                  },
                  'neutralMinionsKilledYourJungle': {
                    'type': 'integer',
                  },
                  'totalTimeCrowdControlDealt': {
                    'type': 'integer',
                  },
                  'sightWardsBought': {
                    'type': 'integer',
                  },
                  'visionWardsBought': {
                    'type': 'integer',
                  },
                },
              },
              }
            },
          }
        },
        'required': ['games'],
      }
    },
    'required': ['id', 'type', 'attributes'],
  }

  ProBuild = {
    'type': 'object',
    'properties': {
      'id': {
        'type': 'integer',
      },
      'matchId': {
        'type': 'integer',
      },
      'matchCreation': {
        'type': 'integer',
      },
      'region': {
        'type': 'string',
      },
      'spell1Id': {
        'type': 'integer',
      },
      'spell2Id': {
        'type': 'integer',
      },
      'highestAchievedSeasonTier': {
        'type': 'string',
      },
      'masteries': {
        'type': 'array',
        'items': {
          'type': 'object',
          'properties': {
            'rank': {
              'type': 'integer',
            },
            'masteryId': {
              'type': 'integer',
            },
          },
        },
      },
      'runes': {
        'type': 'array',
        'items': {
          'type': 'object',
          'properties': {
            'rank': {
              'type': 'integer',
            },
            'runeId': {
              'type': 'integer',
            },
            'name': {
              'type': 'string',
            },
            'description': {
              'type': 'string',
            },
            'image': {
              'type': 'object',
              'properties': {
                'full': {
                  'type': 'string',
                },
              },
            },
          },
          'required': ['rank', 'runeId', 'name', 'description', 'image'],
        },
      },
      'stats': {
        'type': 'object',
      },
      'itemsOrder': {
        'type': 'array',
        'items': {
          'type': 'object',
          'properties': {
            'itemId': {
              'type': 'integer',
            },
            'timestamp': {
              'type': 'integer',
            },
          },
        },
      },
      'skillsOrder': {
        'type': 'array',
        'items': {
          'type': 'object',
          'properties': {
            'skillSlot': {
              'type': 'integer',
            },
            'timestamp': {
              'type': 'integer',
            },
            'levelUpType': {
              'type': 'string',
            },
          },
        },
      },
    },
    'required': ['id', 'matchId', 'matchCreation', 'region', 'spell1Id', 'spell2Id', 'highestAchievedSeasonTier', 'masteries', 'runes', 'stats', 'itemsOrder', 'skillsOrder']
  }

  ProBuilds = {
    'type': 'object',
    'properties': {
      'proBuilds': {
        'type': 'array',
        'items': self::ProBuild,
      },
    },
  }

  ProPlayer = {
    'type': 'object',
    'properties': {
      'id': { 'type': 'string' },
      'type': { 'type': 'string' },
      'attributes': {
        'type': 'object',
        'properties': {
          'name': { 'type': 'string' },
          'imageUrl': { 'type': 'string' },
          'realName': { 'type': 'string' },
          'role': { 'type': 'string' },
        },
        'required': ['name', 'imageUrl', 'realName', 'role'],
      },
    },
    'required': ['id', 'type'],
  }

  ProPlayers = {
    'type': 'array',
    'items': self::ProPlayer,
  }
end
