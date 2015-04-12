class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @categories = Category.all
    @new_category = Category.new

    @users = User.all
  end

  protected

  def check_admin
    unless current_user.admin?
      flash[:alert] = "Not Admin!"
      redirect_to root_path
      return
    end
  end

end
