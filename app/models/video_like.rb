class VideoLike < ApplicationRecord
  belongs_to :user
  belongs_to :video
end
