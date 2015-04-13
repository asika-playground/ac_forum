class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :get_category, :only => [:update, :destroy]

  def create
    @category = Category.new(cate_params)

    @category.save
    redirect_to admin_root_path
  end

  def update
    if @category.update(cate_params)
      flash[:notice] = "Category Renamed."
    else
      flash[:alert] = "Category Rename Failed."
    end

    redirect_to admin_root_path
  end

  def destroy
    if @category.topics.size == 0
      @category.destroy
    end

    redirect_to admin_root_path
  end

  protected

  def get_category
    @category = Category.find(params[:id])
  end

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
