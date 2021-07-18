class AddArticleTitleToLikes < ActiveRecord::Migration[6.1]
  def change
    add_column :likes, :article_title, :string
  end
end
