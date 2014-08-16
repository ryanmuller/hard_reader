class ApplicationMailer < ActionMailer::Base
  def mail(opts)
    #RestClient.post "http://localhost", opts.merge(from: "cognitionmachine@gmail.com")
  end
end
