class TryAddingBackResponseColumn < ActiveRecord::Migration
  def change
    add_column :queries, :response, :json
  end
end
