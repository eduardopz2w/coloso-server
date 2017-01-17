class CreateGamesRecents < ActiveRecord::Migration[5.0]
  def change
    create_table :games_recents do |t|
      t.integer :summonerId
      t.string :region
      t.json :games

      t.timestamps
    end
  end
end
