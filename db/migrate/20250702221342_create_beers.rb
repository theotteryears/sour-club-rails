class CreateBeers < ActiveRecord::Migration[8.0]
  def change
    create_table :beers do |t|
      t.string :name
      t.string :brewery
      t.integer :sourness
      t.integer :design
      t.string :jenesaisquoi

      t.timestamps
    end
  end
end
