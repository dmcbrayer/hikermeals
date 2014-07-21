class SignupsController < ApplicationController
  def new
  	@signup = Signup.new
  end

  def create
  	@signup = Signup.new(signup_params)

  	respond_to do |format|
  		if @signup.save
        	format.html { redirect_to root_url, notice: 'Thanks for signing up! We will be in touch!' }
      	else
        	format.html { render :new }
      	end
  	end
  end

  def dwj
    @signups_count = Signup.all.count
  end


  private

  	# Never trust parameters from the scary internet, only allow the white list through.
    def signup_params
      params.require(:signup).permit(:email)
    end
end
