class RemoveResponseJsonColumn < ActiveRecord::Migration
  def change
    remove_column :queries, :response_json
  end
end
