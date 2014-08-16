class NoteMailer < ApplicationMailer
  def to_read_email(note)
    mail(from: "note-#{note.id}@mg.learnstream.org",
         to: note.user_email,
         subject: "For you to read: #{note.title}",
         body: "Go to #{note.url} then reply to this email with your summary.")
  end
end
