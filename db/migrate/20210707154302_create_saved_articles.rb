class CreateSavedArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :saved_articles do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :article, null: false, foreign_key: true
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
