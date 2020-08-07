class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  validates :user_id,presence: true
  validates :title,presence: true
  VALID_URL_REGEX = /\A#{URI::regexp(%w(http https))}\z/i
  validates :url,presence: true,format: {with: VALID_URL_REGEX}
end
