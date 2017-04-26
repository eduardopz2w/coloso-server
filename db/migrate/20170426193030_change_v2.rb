class ChangeV2 < ActiveRecord::Migration[5.0]
  def change
    rename_column :summoners, :urid, :id
    rename_column :runes, :summonerUrid, :summonerId
    rename_column :masteries, :summonerUrid, :summonerId
    rename_column :champions_masteries, :summonerUrid, :summonerId
    rename_column :stats_summaries, :summonerUrid, :summonerId
    rename_column :league_entries, :summonerUrid, :summonerId
    rename_column :games_recents, :summonerUrid, :summonerId
    rename_column :pro_summoners, :summonerUrid, :summonerId
    rename_column :stats_rankeds, :summonerUrid, :summonerId
    rename_column :matches, :matchUrid, :id

    change_table :pro_builds do |t|
      t.integer :matchDuration, :limit => 8
      t.string :season
      t.string :matchVersion
      t.rename :matchUrid, :matchId
    end
  end

  def down
    rename_column :summoners, :id, :urid
    rename_column :runes, :summonerId, :summonerUrid
    rename_column :masteries, :summonerId, :summonerUrid
    rename_column :champions_masteries, :summonerId, :summonerUrid
    rename_column :stats_summaries, :summonerId, :summonerUrid
    rename_column :league_entries, :summonerId, :summonerUrid
    rename_column :games_recents, :summonerId, :summonerUrid
    rename_column :pro_summoners, :summonerId, :summonerUrid
    rename_column :stats_rankeds, :summonerId, :summonerUrid
    rename_column :matches, :id, :matchUrid

    change_table :pro_builds do |t|
      t.remove :matchDuration
      t.remove :season
      t.remove :matchVersion
      t.rename :matchId, :matchUrid
    end
  end
end
