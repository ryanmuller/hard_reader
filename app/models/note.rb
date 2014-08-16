class Note < ActiveRecord::Base
  belongs_to :user

  scope :has_summary, -> { where.not(summary: nil) }
  scope :reviewable, -> { has_summary.where(sent_at: nil).where("updated_at <= ?", latest_to_review) }

  delegate :email, to: :user, prefix: true

  TO_READ_EMAIL_ROUTE = "read@#{ENV["MAILGUN_DOMAIN"]}"
  STRICT_URL_PATTERN = /\b((https?:\/\/|www\.)[^\s]+)\b/ 
  LIBERAL_URL_PATTERN = /\b((https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.#-]*)*)\b/

  def email_route
    "note-#{id}@#{ENV["MAILGUN_DOMAIN"]}"
  end

  def self.extract_url(text)
    Array(STRICT_URL_PATTERN.match(text))[0] \
      || Array(LIBERAL_URL_PATTERN.match(text))[0]
  end

  def self.id_by_email_route(email_route)
     # note-123@mg.learnstream.org -> 123
     email_route.split("@")[0].split("-")[1].to_i
  end

  def self.latest_to_review
    6.days.ago
  end
end
