class Video < ApplicationRecord
    include Visible
    has_many :video_comments, dependent: :destroy

    validates :title, presence: true
    validates :body, presence: true, length: { minimum: 10 }

    VALID_STATUSES = ['public','private','archived']

    validates :status, inclusion: { in: VALID_STATUSES }

    def archived?
        status == 'archived'
    end
end