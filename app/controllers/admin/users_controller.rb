class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :get_user

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_root_path
    else
      render :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:bio, :role)
  end

  def get_user
    @user = User.find(params[:id])
  end

  def check_admin
    unless current_user.admin?
      flash[:alert] = "Not Admin!"
      redirect_to root_path
      return
    end
  end

end
