class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:email].downcase
    password = params[:password]

    user = User.find_by_email(email)

    if user && user.authenticate(password)
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
