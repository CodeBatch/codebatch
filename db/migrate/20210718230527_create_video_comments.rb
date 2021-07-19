class CreateVideoComments < ActiveRecord::Migration[6.1]
  def change
    create_table :video_comments do |t|
      t.string :commenter
      t.text :body
      t.references :video, null: false, foreign_key: true

      t.timestamps
    end
  end
end
