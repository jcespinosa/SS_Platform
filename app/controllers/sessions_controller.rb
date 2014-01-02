class SessionsController < ApplicationController
  def new
    if signed_in?
      redirect_to current_user
    else
      render 'new'
    end
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Nombre de usuario o contaseña no válidos' # Not quite right!
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
