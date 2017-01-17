Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/riot-api/:region/summoner/by-name/:summonerName', to: 'summoners#findByName'
  get '/riot-api/:region/summoner/:summonerId', to: 'summoners#findById'
end
