class AddFormatToProjects < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :video_id, :format
  end
end
