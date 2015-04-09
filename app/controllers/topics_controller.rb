class TopicsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_action :get_topic, :only => [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.all
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
