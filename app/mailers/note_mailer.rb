class NoteMailer < ApplicationMailer
  def to_read_email(note)
    mail(from: "Hard Reader <#{note.email_route}>",
         to: note.user_email,
         subject: "For you to read: #{note.title}",
         text: "Go to #{note.url} then reply to this email with your summary.",
         html: "Go to <a href=\"#{note.url}\">#{note.title || note.url}</a> then reply to this email with your summary.")
  end

  def review_email(user)
    return if user.notes_reviewable.empty?

    summary_texts = user.notes_reviewable.map(&:summary_body)

    mail(from: "Hard Reader <#{Note::REVIEW_EMAIL_ROUTE}>",
         to: user.email,
         subject: "Your review from Hard Reader",
         text: (["Your summaries from last week:"]+summary_texts).join("\n\n"))

    user.notes_reviewable.update_all(sent_at: Time.now.utc)
  end
end
