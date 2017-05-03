class ChangeV2 < ActiveRecord::Migration[5.0]
  def change
    add_column :summoners, :accountId, :integer, :limit => 8
    rename_column :summoners, :urid, :id
    rename_column :runes, :summonerUrid, :summonerId
    rename_column :masteries, :summonerUrid, :summonerId
    rename_column :champions_masteries, :summonerUrid, :summonerId
    rename_column :stats_summaries, :summonerUrid, :summonerId
    rename_column :league_entries, :summonerUrid, :summonerId
    rename_column :games_recents, :summonerUrid, :summonerId
    rename_column :pro_summoners, :summonerUrid, :summonerId
    add_column :pro_summoners, :accountId, :integer, :limit => 8
    rename_column :stats_rankeds, :summonerUrid, :summonerId
    remove_column :games_recents, :region
    remove_column :region, :region

    change_table :pro_builds do |t|
      t.rename :matchUrid, :gameId
      t.integer :seasonId
      t.integer :queueId
      t.string :gameVersion
      t.string :platformId
      t.string :gameMode
      t.integer :mapId
      t.string :gameType
      t.rename :matchCreation, :gameCreation
      t.integer :gameDuration, :limit => 8
      t.remove :region
    end

    change_table :matches do |t|
      t.rename :matchUrid, :id
      t.rename :matchType, :gameType
      t.remove :region
      t.integer :seasonId
      t.integer :queueId
      t.string :gameVersion
      t.string :platformId
      t.rename :matchMode, :gameMode
      t.rename :matchCreation, :gameCreation
      t.rename :matchDuration, :gameDuration
    end
  end

  def down
    remove_column :summoners, :accountId
    remove_column :pro_summoners, :accountId
    rename_column :summoners, :id, :urid
    rename_column :runes, :summonerId, :summonerUrid
    rename_column :masteries, :summonerId, :summonerUrid
    rename_column :champions_masteries, :summonerId, :summonerUrid
    rename_column :stats_summaries, :summonerId, :summonerUrid
    rename_column :league_entries, :summonerId, :summonerUrid
    rename_column :games_recents, :summonerId, :summonerUrid
    rename_column :pro_summoners, :summonerId, :summonerUrid
    rename_column :stats_rankeds, :summonerId, :summonerUrid
    add_column :games_recents, :region, :string
    add_column :region, :region, :string

    change_table :pro_builds do |t|
      t.rename :gameId, :matchUrid
      t.remove :seasonId
      t.remove :queueId
      t.remove :gameVersion
      t.remove :platformId
      t.remove :gameMode
      t.remove :mapId
      t.remove :gameType
      t.rename :gameCreation, :matchCreation
      t.remove :gameDuration, :limit => 8
      t.string :region
    end

    change_table :matches do |t|
      t.rename :id, :matchUrid
      t.rename :gameType, :matchType
      t.string :region
      t.remove :seasonId
      t.remove :queueId
      t.remove :gameVersion
      t.remove :platformId
      t.rename :gameMode, :matchMode
      t.rename :gameCreation, :matchCreation
      t.rename :gameDuration, :matchDuration
    end
  end
end
