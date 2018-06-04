class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :title
      t.string :cover_url
      t.integer :year
      t.text :description
      t.boolean :featured
      t.string :developer
      t.string :publisher
      t.string :platforms
      t.string :gameplay
      t.string :genre
      t.string :esrb

      t.timestamps
    end
  end
end
