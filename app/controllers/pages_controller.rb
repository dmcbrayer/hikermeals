class PagesController < ApplicationController
  def home
  	@signup = Signup.new
  end

  def about
  end

  def contact
  end

  def legal
  end
end
