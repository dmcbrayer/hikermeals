class Signup < ActiveRecord::Base

  belongs_to :referrer, :class_name => "Signup", :foreign_key => "referrer_id"
  has_many :referrals, :class_name => "Signup", :foreign_key => "referrer_id"
	
  before_save { self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
    uniqueness: {case_sensitive: false}

  validates :referral_code, :uniqueness => true

  before_create :create_referral_code

  private
  
    def create_referral_code
        referral_code = SecureRandom.hex(5)
        @collision = Signup.find_by_referral_code(referral_code)

        while !@collision.nil?
            referral_code = SecureRandom.hex(5)
            @collision = Signup.find_by_referral_code(referral_code)
        end

        self.referral_code = referral_code
    end

end
