class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])

    if @user # valid credentials
      login!(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = ["Invalid email/password :("]
      render :new
    end
  end

  def destroy
    logout(current_user)
    redirect_to new_session_url
  end

end
