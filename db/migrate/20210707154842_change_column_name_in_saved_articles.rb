class ChangeColumnNameInSavedArticles < ActiveRecord::Migration[6.1]
  def change
    rename_column :saved_articles, :title, :article_title
    rename_column :saved_articles, :url, :article_url
  end
end
