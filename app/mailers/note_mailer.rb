class NoteMailer < ApplicationMailer
  def to_read_email(note)
    mail(from: "HardReader <#{note.email_route}>",
         to: note.user_email,
         subject: "For you to read: #{note.title}",
         text: "Go to #{note.url} then reply to this email with your summary.",
         html: "Go to <a href=\"#{note.url}\">#{note.title || note.url}</a> then reply to this email with your summary.")
  end
end
