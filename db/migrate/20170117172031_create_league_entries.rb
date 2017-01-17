class CreateLeagueEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :league_entries do |t|
      t.integer :summonerId
      t.string :region
      t.json :entries

      t.timestamps
    end
  end
end
