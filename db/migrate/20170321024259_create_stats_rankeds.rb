class CreateStatsRankeds < ActiveRecord::Migration[5.0]
  def change
    create_table :stats_rankeds do |t|
      t.string :summonerUrid, null: false
      t.json :champions

      t.timestamps
    end
  end
end
