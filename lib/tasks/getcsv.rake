require 'csv'

namespace :hikermeals do
	desc "Will output CSV's for all users in database"
	task :getcsv => :environment do
		signups = Signup.all

		
		CSV.open("#{Rails.root}/lib/assets/Signups.csv", "wb") do |csv|
			signups.each do |signup|
				csv << [signup.email]
			end
		end
	end
end