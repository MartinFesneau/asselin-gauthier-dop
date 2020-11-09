class AddVideoIdToProject < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :video_id, :string
  end
end
