class CreateSummoners < ActiveRecord::Migration[5.0]
  def change
    create_table :summoners, id: false do |t|
      t.string :urid, unique: true, null: false, primary_key: true
      t.string :name
      t.integer :profileIconId
      t.integer :summonerLevel
      t.string :region
      t.timestamps
    end
  end
end
