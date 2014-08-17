namespace :note_mailer do
  desc "Mail reviews to all users with reviewable notes"
  task all_reviews: :environment do
    User.pluck(:id).each do |user_id|
      ReviewEmailWorker.perform_async(user_id)
    end
  end
end
