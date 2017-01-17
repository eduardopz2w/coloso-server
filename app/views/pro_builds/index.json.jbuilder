json.proBuilds @proBuilds do |proBuild|
  json.id proBuild.id
  json.matchId proBuild.matchId
  json.matchCreation proBuild.matchCreation
  json.region proBuild.region
  json.spell1Id proBuild.spell1Id
  json.spell2Id proBuild.spell2Id
  json.championId proBuild.championId
  json.highestAchievedSeasonTier proBuild.highestAchievedSeasonTier
  json.masteries proBuild.masteries
  json.runes proBuild.runes
  json.stats proBuild.stats
  json.itemsOrder proBuild.itemsOrder
  json.skillsOrder proBuild.skillsOrder
  json.proSummoner proBuild.pro_summoner.slice(:id, :summonerId, :region)
  json.proPlayer proBuild.pro_summoner.pro_player.slice(:id, :name, :imageUrl, :realName, :role)
end

json.pagination do
  json.currentPage @proBuilds.current_page
  json.totalPages @proBuilds.total_pages
end
