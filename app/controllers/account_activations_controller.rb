class AccountActivationsController < ApplicationController
  def edit
    @user = User.find_by(email: params[:email])
    if @user && !@user.activated? && @user.authorized?(params[:id])
      @user.activate
      log_in @user
      flash[:success] = "Account activated"
      redirect_to root_url
    else
      flash[:errors] = "Invalid activation"
      redirect_to root_url
    end
  end
end
