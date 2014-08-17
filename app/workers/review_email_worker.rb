class ReviewEmailWorker
  include Sidekiq::Worker

  def perform(user_id)
    NoteMailer.review_email(user_id)
  end
end
