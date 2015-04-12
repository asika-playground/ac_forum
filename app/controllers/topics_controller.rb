class TopicsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_action :get_topic, :only => [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.all

    if params[:cate]
      # @topics = @topics.where(:category_id => params[:cate])
      @topics = Category.find(params[:cate]).topics
    end

    if params[:sort]

      order = "ASC"
      if params[:order] == "desc"
        order = "DESC"
      end

      @topics = @topics.order("topics.%{sort} %{order}" % {:sort => params[:sort], :order => order})
      # @topics = @topics.sort {|t| t.send params[:sort]}
    end

    @topics = @topics.page( params[:page] ).per(10)
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
