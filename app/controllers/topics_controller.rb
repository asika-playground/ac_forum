class TopicsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_action :get_topic, :only => [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.all
    @categories = Category.all

    if params[:cate]

      if params[:cate].to_i == 0
        # uncategoried
        uncat = Topic.select {|r| r.categories.size == 0}

        @category = "Uncategoried"

        # convert array to ActiveRecord::Relation
        # http://stackoverflow.com/questions/17331862/converting-an-array-of-objects-to-activerecordrelation
        @topics = Topic.where(id: uncat.map(&:id))
      else
        @category = Category.find(params[:cate]).name
        @topics = Category.find(params[:cate]).topics
      end

    end

    sort = params[:sort] || "updated_at"

    order = "DESC"
    if params[:order] == "asc"
      order = "ASC"

      # @topics = @topics.order("topics.%{sort} %{order}" % {:sort => params[:sort], :order => order})
    end

    @topics = @topics.order("topics.%{sort} %{order}" % {:sort => sort, :order => order})

    @topics = @topics.page( params[:page] ).per(20)
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
    @topic.destroy

    flash[:alert] = "Done 刪除!!"
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
