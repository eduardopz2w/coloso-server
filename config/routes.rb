Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/riot-api/summoner/by-name/:summonerName', to: 'summoners#findByName'
  get '/riot-api/summoner/:sumUrid', to: 'summoners#findById'
  get '/riot-api/summoner/:sumUrid/runes', to: 'summoners#runes'
  get '/riot-api/summoner/:sumUrid/masteries', to: 'summoners#masteries'
  get '/riot-api/summoner/:sumUrid/champions-mastery', to: 'summoners#championsMastery'
  get '/riot-api/summoner/:sumUrid/stats/summary', to: 'summoners#statsSummary'
  get '/riot-api/summoner/:sumUrid/league/entry', to: 'summoners#leagueEntry'
  get '/riot-api/summoner/:sumUrid/games/recent', to: 'summoners#gamesRecent'
  get '/riot-api/summoner/:sumUrid/games/current', to: 'summoners#gameCurrent'
  resources 'pro_players', path: 'pro-players', only: ['index', 'create', 'destroy']
  resources :pro_builds, path: 'pro-builds', only: ['index', 'show']
end
