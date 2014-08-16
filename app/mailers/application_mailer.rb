class ApplicationMailer < ActionMailer::Base
  API_KEY = ENV["MAILGUN_API_KEY"]
  API_URL = "https://api:#{API_KEY}@api.mailgun.net/v2/#{ENV["MAILGUN_DOMAIN"]}"

  def mail(opts)
    RestClient.post API_URL+"/messages", opts
  end
end
