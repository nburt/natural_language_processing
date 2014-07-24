class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.json :response
      t.string :filename
      t.timestamps
    end
  end
end
