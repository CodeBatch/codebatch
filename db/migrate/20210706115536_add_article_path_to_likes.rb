class AddArticlePathToLikes < ActiveRecord::Migration[6.1]
  def change
    add_column :likes, :article_path, :string
  end
end
