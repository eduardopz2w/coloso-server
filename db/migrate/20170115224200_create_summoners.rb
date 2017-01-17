class CreateSummoners < ActiveRecord::Migration[5.0]
  def change
    create_table :summoners do |t|
      t.string :name
      t.integer :summonerId
      t.integer :profileIconId
      t.integer :summonerLevel
      t.string :region
      t.timestamps
    end
  end
end
