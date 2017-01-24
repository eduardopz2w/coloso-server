class CreateRunes < ActiveRecord::Migration[5.0]
  def change
    create_table :runes do |t|
      t.string :summonerUrid, unique: true, null: false
      t.json :pages
      t.timestamps
    end
  end

  def down
    drop_table :runes
  end
end
