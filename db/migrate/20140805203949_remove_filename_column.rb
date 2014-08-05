class RemoveFilenameColumn < ActiveRecord::Migration
  def change
    remove_column :queries, :filename
  end
end
