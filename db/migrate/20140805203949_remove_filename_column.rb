class RemoveFilenameColumn < ActiveRecord::Migration
  def change
    remove_column :queries, :filename, :string
  end
end
