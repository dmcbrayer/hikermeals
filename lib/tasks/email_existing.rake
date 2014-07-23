namespace :hikermeals do
	desc "Generates referral codes for everyone in the DB and then emails them with their referral link"
	task :email_existing => :environment do
		signups = Signup.all

		signups.each do |signup|
			signup.create_referral_code
			signup.early_adopter = true
			signup.save


			SignupsMailer.referral_email(signup).deliver
		end
	end
end
