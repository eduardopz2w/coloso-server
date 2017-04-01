Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
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
  get '/riot-api/matches/:matchUrid', to: 'matches#show'
  get '/status/android-app', to:'status#android_app'
  resources :pro_players, path: 'pro-players', only: ['index']
  resources :pro_builds, path: 'pro-builds', only: ['index', 'show']
end
