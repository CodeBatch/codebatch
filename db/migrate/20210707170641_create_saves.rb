class CreateSaves < ActiveRecord::Migration[6.1]
  def change
    create_table :saves do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :article, null: false, foreign_key: true
      t.string :article_title
      t.string :article_url

      t.timestamps
    end
  end
end
