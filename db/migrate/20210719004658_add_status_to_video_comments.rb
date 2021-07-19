class AddStatusToVideoComments < ActiveRecord::Migration[6.1]
  def change
    add_column :video_comments, :status, :string
  end
end
