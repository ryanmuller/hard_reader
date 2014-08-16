namespace :note_mailer do
  desc "Mail reviews to all users with reviewable notes"
  task all_reviews: :environment do
    User.all.each do |user|
      NoteMailer.delay.review_email(user)
    end
  end
end
