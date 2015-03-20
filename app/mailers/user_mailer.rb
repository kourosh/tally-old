class UserMailer < ActionMailer::Base
  default from: "Tally <info@tally.us>"

  def pac_signup(pac)
  	@pac = pac

  	mail(to: @pac.pac_email, subject: "Tally: Confirm Your Account")
  end
end
