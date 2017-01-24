class CreateStatsSummaries < ActiveRecord::Migration[5.0]
  def change
    create_table :stats_summaries do |t|
      t.string :summonerUrid, null: false
      t.string :season
      t.json :playerStatSummaries

      t.timestamps
    end
  end
end
