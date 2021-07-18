class AddUserEmailToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :user_email, :string
  end
end
