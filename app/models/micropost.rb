class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  validates :user_id,presence: true
  VALID_URL_REGEX = /\A#{URI::regexp(%w(http https))}\z/i
  validates :url,presence: true,format: {with: VALID_URL_REGEX}

  def save_http_response
    agent = Mechanize.new
    page = agent.get(self.url)
    title = page.title
    og_meta = page.at('meta[property="og:image"]')
    if og_meta.nil?
        og_image = 'default.png'
    else
        og_image = og_meta[:content]
    end

    update_attributes(title: title,og_image: og_image)
  end
end
