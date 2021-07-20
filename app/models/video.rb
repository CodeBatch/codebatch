class Video < ApplicationRecord
    include Visible
    has_many :video_comments, dependent: :destroy

    has_many :video_likes, dependent: :destroy
    def video_liked?(user)
        !!self.video_likes.find{|video_like| video_like.user_id == user.id}
    end

    validates :title, presence: true
    validates :body, presence: true, length: { minimum: 10 }

    VALID_STATUSES = ['public','private','archived']

    validates :status, inclusion: { in: VALID_STATUSES }

    def archived?
        status == 'archived'
    end
end