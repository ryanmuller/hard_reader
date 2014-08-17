class NoteMailer < ApplicationMailer
  include ActionView::Helpers::SanitizeHelper

  def to_read_email(note)
    @note = note

    mail(from: "Hard Reader <#{note.email_route}>",
         to: note.user_email,
         subject: "For you to read",
         html: generate_html,
         text: generate_text)
  end

  def review_email(user)
    return if user.notes_reviewable.empty?

    @user = user

    out = mail(from: "Hard Reader <#{Note::REVIEW_EMAIL_ROUTE}>",
               to: user.email,
               subject: "Your review from Hard Reader",
               html: generate_html,
               text: generate_text)

    user.notes_reviewable.update_all(sent_at: Time.now.utc)
    return out
  end

  def generate_html
    @html ||= collect_responses({})[0][:body]
  end

  def generate_text
    @text ||= strip_tags(generate_html)
  end
end
