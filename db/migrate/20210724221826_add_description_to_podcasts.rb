class AddDescriptionToPodcasts < ActiveRecord::Migration[6.1]
  def change
    add_column :podcasts, :description, :text
  end
end
