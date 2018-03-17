class CreateTowns < ActiveRecord::Migration
  def change
    create_table :towns do |t|
      t.string :name
      t.string :zipcode
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps null: false
    end
  end
end
