class CreateMasteries < ActiveRecord::Migration[5.0]
  def change
    create_table :masteries do |t|
      t.string :summonerUrid, unique: true, null: false
      t.json :pages
      t.timestamps
    end
  end
end
