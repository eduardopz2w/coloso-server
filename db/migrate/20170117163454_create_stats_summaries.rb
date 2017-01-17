class CreateStatsSummaries < ActiveRecord::Migration[5.0]
  def change
    create_table :stats_summaries do |t|
      t.integer :summonerId
      t.string :region
      t.string :season
      t.json :playerStatSummaries

      t.timestamps
    end
  end
end
