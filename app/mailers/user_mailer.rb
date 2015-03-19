class UserMailer < ActionMailer::Base
  default from: "info@tally.us"

  def pac_signup(pac)
  	@pac = pac

  	mail(to: @pac.pac_email, subject: "Connect your Stripe Account")
  end
end
