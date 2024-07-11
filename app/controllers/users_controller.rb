class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:profile, :account, :profile_edit, :profile_update]
  def profile
  end

  def account
  end

  def profile_edit 
    @user = current_user
  end

  def profile_update 
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "プロフィール情報が更新されました。"
      redirect_to users_profile_path
    else
      render :profile_edit
    end
  end

  def user_params
    params.require(:user).permit(:avatar, :userprofile, :username)
  end
end
