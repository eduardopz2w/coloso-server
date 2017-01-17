class CreateProSummoners < ActiveRecord::Migration[5.0]
  def change
    create_table :pro_summoners do |t|
      t.integer :summonerId
      t.string :region
      t.datetime :lastCheck
      t.belongs_to :pro_player
      t.timestamps
    end
  end
end
