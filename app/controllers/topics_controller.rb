class TopicsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_action :get_topic, :only => [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.all
    @categories = Category.all

    if params[:cate]

      if params[:cate] == "0"
        # uncategoried
        uncat = Topic.select {|r| r.categories.size == 0}

        # convert array to ActiveRecord::Relation
        # http://stackoverflow.com/questions/17331862/converting-an-array-of-objects-to-activerecordrelation
        @topics = Topic.where(id: uncat.map(&:id))
      else
        @topics = Category.find(params[:cate]).topics
      end

    end

    unless params[:q]

    end

    @q = @topics.ransack(params[:q])
    @q.sorts = 'updated_at DESC' if @q.sorts.empty?
    @topics = @q.result.page(params[:page])
  end

  def about
    @user_count = User.all.size
    @topic_count = Topic.all.size
    @comment_count = Comment.all.size
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new( topic_param )

    @topic.user = current_user

    if @topic.save
        flash[:notice] = "Successfully Posted."

        redirect_to topics_path
    else
        render :new
    end
  end

  def show
    @topic.update(:views => @topic.views+1)
  end

  def edit
  end

  def update
    if @topic.update(topic_param)
        flash[:notice] = "Successfully Edited."

        redirect_to topic_path(@topic)
    else
        render :edit
    end
  end

  def destroy
    if can_delete_by?(current_user)
      @topic.destroy

      flash[:alert] = "Done Deleting!!"
    else
      flash[:alert] = "No Permission to Delete!!"
    end

    redirect_to topics_path
  end

  protected

  def get_topic
    @topic = Topic.find(params[:id])
  end

  def topic_param
    params.require(:topic).permit(:title, :content, :user_id, :category_ids => [])
  end

end
