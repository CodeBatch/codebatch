class VideoComment < ApplicationRecord
  include Visible
  belongs_to :video
end
