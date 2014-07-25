class DropResponseColumn < ActiveRecord::Migration
  def change
    remove_column :queries, :response
  end
end
