class SignupsController < ApplicationController
  before_action :skip_first_page, :only => :new

  def new
  	@signup = Signup.new

    respond_to do |format|
      format.html
    end
  end

  def create
    # Get user to see if they have already signed up
    @signup = Signup.find_by(email: params[:signup][:email]);
    
  	if @signup.nil?
      @signup = Signup.new(signup_params)

      @referred_by = Signup.find_by(referral_code: cookies[:h_ref])

      puts '------------'
      puts @referred_by.email if @referred_by
      puts params[:signup][:email].inspect
      puts request.env['HTTP_X_FORWARDED_FOR'].inspect
      puts '------------'

      if !@referred_by.nil?
        @signup.referrer = @referred_by
      end

      @signup.save
      
    end

  	respond_to do |format|
  		if !@signup.nil?
          cookies[:h_email] = {:value => @signup.email}
        	format.html { redirect_to :thanks }
      	else
        	format.html { render :new, :alert => "Something went wrong!" }
      	end
  	end
  end


  def dwj
    @signups_count = Signup.all.count
  end

  def thanks
    email = cookies[:h_email]

    @signup = Signup.find_by(email: email)

    respond_to do |format|
      if !@signup.nil?
          format.html #refer.html.erb
      else
          format.html { redirect_to root_path, :alert => "Something went wrong!" }
      end
    end

  end

  private

    def skip_first_page
        if !Rails.application.config.ended
            email = cookies[:h_email]
            if email and !Signup.find_by(email: email).nil?
                redirect_to '/thanks'
            else
                cookies.delete :h_email
            end
        end
    end

  	# Never trust parameters from the scary internet, only allow the white list through.
    def signup_params
      params.require(:signup).permit(:email)
    end
end
