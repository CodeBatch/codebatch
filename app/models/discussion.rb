class Discussion < ApplicationRecord
      belongs_to :article

  include Visible
  has_many :comments, dependent: :destroy
  
  has_many :likes, dependent: :destroy
  def liked?(user)
      !!self.likes.find{|like| like.user_id == user.id}
  end

  has_many :stores, dependent: :destroy
  def stored?(user)
      !!self.stores.find{|store| store.user_id == user.id}
  end

  
  def self.search(search)
    # Title is for the above case, the OP incorrectly had 'name'
    where("title LIKE ?", "%#{search}%")
  end

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10}
end
