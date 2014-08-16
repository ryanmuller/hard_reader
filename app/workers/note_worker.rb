class NoteWorker
  include Sidekiq::Worker

  def perform(user)
    # query for correct set of notes
    # SummaryMailer.mail
  end
end
