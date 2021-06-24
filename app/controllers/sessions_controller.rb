class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    #If user exists && pw is correct
    if user && user.authenticate(params[:password])
      #Save uid inside cookie
      session[:user_id] = user_id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
