Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/riot-api/:region/summoner/by-name/:summonerName', to: 'summoners#findByName'
  get '/riot-api/:region/summoner/:summonerId', to: 'summoners#findById'
  get '/riot-api/:region/summoner/:summonerId/runes', to: 'summoners#runes'
  get '/riot-api/:region/summoner/:summonerId/masteries', to: 'summoners#masteries'
  get '/riot-api/:region/summoner/:summonerId/champions-mastery', to: 'summoners#championsMastery'
  get '/riot-api/:region/summoner/:summonerId/stats/summary', to: 'summoners#statsSummary'
  get '/riot-api/:region/summoner/:summonerId/league/entry', to: 'summoners#leagueEntry'
  get '/riot-api/:region/summoner/:summonerId/games/recent', to: 'summoners#gamesRecent'
  get '/riot-api/:region/summoner/:summonerId/games/current', to: 'summoners#gameCurrent'
  get '/pro-builds', to: 'pro_builds#index'
  resources :pro_players, path: 'pro-players'
end
