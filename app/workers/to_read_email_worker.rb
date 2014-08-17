class ToReadEmailWorker
  include Sidekiq::Worker

  def perform(note_id)
    NoteMailer.to_read_email(note_id)
  end
end
