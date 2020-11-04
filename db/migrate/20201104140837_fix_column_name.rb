class FixColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :type, :category
  end
end
