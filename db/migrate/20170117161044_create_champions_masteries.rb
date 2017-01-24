class CreateChampionsMasteries < ActiveRecord::Migration[5.0]
  def change
    create_table :champions_masteries do |t|
      t.string :summonerUrid, unique: true, null: false
      t.json :masteries

      t.timestamps
    end
  end
end
