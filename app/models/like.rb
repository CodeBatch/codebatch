class Like < ApplicationRecord
  belongs_to :user
  belongs_to :article
  belongs_to :video
  belongs_to :podcast

  validates :user_id, uniqueness: {scope: :article_id}
  validates :user_id, uniqueness: {scope: :video_id}
  validates :user_id, uniqueness: {scope: :podcast_id}
end
