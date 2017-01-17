# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

proPlayer = ProPlayer.find_or_create_by({
  :name => "TheOddOne",
  :imageUrl => "https://pedronalbert.github.io/coloso-web/images/pros/theoddone.jpg",
  :realName => "Brian Wyllie",
  :role => "jungle",
})

proSummoner = proPlayer.create_pro_summoner({
  :summonerId => 465413,
  :region => "na",
  :lastCheck => 1483936882864,
})

proSummoner.pro_builds.create({
  :matchId => 12345,
  :matchCreation => 12345,
  :region => 'na',
  :spell1Id => 1,
  :spell2Id => 2,
  :championId => 55,
  :highestAchievedSeasonTier => 'highestAchievedSeasonTier',
  :masteries => [],
  :runes => [],
  :stats => {},
  :itemsOrder => [],
  :skillsOrder => [],
})
