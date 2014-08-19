require "digest/sha2"

class DeviseCustomMailer < Devise::Mailer
  default "Message-ID" => "#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@hardreader.herokuapp.com"
end
