class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def create
    @category = Category.new(cate_params)

    @category.save
    redirect_to admin_root_path
  end

  def destroy
    @category = Category.find(params[:id])

    if @category.topics.size == 0
      @category.destroy
    end

    redirect_to admin_root_path
  end

  protected

  def cate_params
    params.require(:category).permit(:name)
  end

  def check_admin
    unless current_user.admin?
      flash[:alert] = "Not Admin!"
      redirect_to root_path
      return
    end
  end

end
