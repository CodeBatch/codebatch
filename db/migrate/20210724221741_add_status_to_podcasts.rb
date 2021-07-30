class AddStatusToPodcasts < ActiveRecord::Migration[6.1]
  def change
    add_column :podcasts, :status, :string
  end
end
