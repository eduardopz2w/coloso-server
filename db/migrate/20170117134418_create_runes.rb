class CreateRunes < ActiveRecord::Migration[5.0]
  def change
    create_table :runes do |t|
      t.integer :summonerId
      t.json :pages
      t.string :region
      t.timestamps
    end
  end
end
