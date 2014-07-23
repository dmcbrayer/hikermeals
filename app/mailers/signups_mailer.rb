class SignupsMailer < ActionMailer::Base
  default from: "Hiker Meals <trailstaff@hikermeals.com>"

  def welcome_email(signup)
  	@signup = signup
  	@twitter_message = "It's like having mountain men pack your #trailfood for you.  Check out @hikermeals!"

  	mail(:to => signup.email, :subject => "Thanks for signing up!")
  end

  def referral_email(signup)
  	@signup = signup
  	@twitter_message = "It's like having mountain men pack your #trailfood for you.  Check out @hikermeals!"

  	mail(:to => signup.email, :subject => "Refer friends to earn discounts on trail food!")
  end
end
