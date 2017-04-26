Rails.application.routes.draw do

  api_version(:module => "V1", :header => {:name => "Accept", :value => "application/vnd.coloso.net; version=1"}, :default => true) do
    match '/riot-api/summoner/by-name/:summonerName', to: 'summoners#findByName', :via => :get
    match '/riot-api/summoner/:sumUrid', to: 'summoners#findById', :via => :get
    match '/riot-api/summoner/:sumUrid/runes', to: 'summoners#runes', :via => :get
    match '/riot-api/summoner/:sumUrid/masteries', to: 'summoners#masteries', :via => :get
    match '/riot-api/summoner/:sumUrid/champions-mastery', to: 'summoners#championsMastery', :via => :get
    match '/riot-api/summoner/:sumUrid/stats/summary', to: 'summoners#statsSummary', :via => :get
    match '/riot-api/summoner/:sumUrid/league/entry', to: 'summoners#leagueEntry', :via => :get
    match '/riot-api/summoner/:sumUrid/games/recent', to: 'summoners#gamesRecent', :via => :get
    match '/riot-api/summoner/:sumUrid/games/current', to: 'summoners#gameCurrent', :via => :get
    match '/riot-api/matches/:matchUrid', to: 'matches#show', :via => :get
    resources :pro_players, path: 'pro-players', only: ['index']
    resources :pro_builds, path: 'pro-builds', only: ['index', 'show']
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/status/android-app', to:'status#android_app'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
