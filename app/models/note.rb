class Note < ActiveRecord::Base
  belongs_to :user

  scope :has_summary, -> { where.not(summary: nil) }
  scope :reviewable, -> { has_summary.where(sent_at: nil).where("updated_at <= ?", latest_to_review) }

  def self.latest_to_review
    6.days.ago
  end
end
