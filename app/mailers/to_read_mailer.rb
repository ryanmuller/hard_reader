class ToReadMailer < ApplicationMailer
  def to_read_email(user, url, title)
    mail(to: user.email,
         subject: "You wanted to read \"#{title}\"",
         body: "Go to #{url}. Then reply with your own summary.")
  end
end
