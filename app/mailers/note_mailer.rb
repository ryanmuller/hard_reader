class NoteMailer < ApplicationMailer
  def to_read_email(note_id)
    @note = Note.find(note_id)

    mail(from: "Hard Reader <#{@note.email_route}>",
         to: @note.user_email,
         subject: "For you to read",
         html: generate_html)
  end

  def review_email(user_id)
    @user = User.find(user_id)

    return if @user.nil? or @user.notes_reviewable.empty?

    mail(from: "Hard Reader <#{Note::REVIEW_EMAIL_ROUTE}>",
         to: @user.email,
         subject: "Your review from Hard Reader",
         html: generate_html)

    @user.notes_reviewable.update_all(sent_at: Time.now.utc)
  end

  def generate_html
    @html ||= collect_responses({})[0][:body]
  end
end
