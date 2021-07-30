class Store < ApplicationRecord
  belongs_to :user
  belongs_to :article
  belongs_to :video
  belongs_to :podcast
end
