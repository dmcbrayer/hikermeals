class SignupsMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(signup)
  	@signup = signup

  	mail(:to => signup.email, :subject => "Thanks for signing up!")
  end
end
