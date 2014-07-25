class AddResponseJsonColumn < ActiveRecord::Migration
  def change
    add_column :queries, :response_json, :text
  end
end
