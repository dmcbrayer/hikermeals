class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :ref_to_cookie

   protected

    def ref_to_cookie
        if params[:ref] && !Rails.application.config.ended
            if !Signup.find_by(referral_code: params[:ref]).nil?
                cookies[:h_ref] = { :value => params[:ref], :expires => 1.week.from_now }
            end

            #this may perhaps be causing the facebook link to just output the basic URL.  Not sure because I think I added this in when I was attempting to fix that problem.
            
            if request.env["HTTP_USER_AGENT"] and !request.env["HTTP_USER_AGENT"].include?("facebookexternalhit/1.1")
                redirect_to proc { url_for(params.except(:ref)) }  
            end
        end
    end


end
