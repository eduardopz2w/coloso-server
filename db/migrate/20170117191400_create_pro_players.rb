class CreateProPlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :pro_players do |t|
      t.string :name
      t.string :imageUrl
      t.string :realName
      t.string :role
      t.timestamps
    end
  end
end
