class AddReferralCodeToSignups < ActiveRecord::Migration
  def change
  	add_column :signups, :referral_code, :string
  	add_column :signups, :referrer_id, :integer
  end
end
