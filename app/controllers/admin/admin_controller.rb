class Admin::AdminController < ApplicationController
  def index
    @categories = Category.all
    @new_category = Category.new

    @users = User.all
  end
end
