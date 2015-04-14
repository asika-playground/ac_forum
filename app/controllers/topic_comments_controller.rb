class TopicCommentsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_action :get_topic

  def new
    @comment = @topic.comments.build
  end

  def create
    @comment = @topic.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Replied."

      redirect_to topic_path(@topic)
    else
      render :new
    end
  end

  def edit
    @comment = @topic.comments.find(params[:id])
  end

  def update
    @comment = @topic.comments.find(params[:id])

    if @comment.update(comment_params)
      flash[:notice] = "Comment Edited."

      redirect_to topic_path(@topic)
    else
      render :edit
    end
  end

  def destroy
    @comment = @topic.comments.find(params[:id])

    if @comment.can_delete_by(current_user)
      @comment.destroy

      flash[:alert] = "Comment Deleted."
    else
      flash[:alert] = "No Permission to Delete!!"
    end

    redirect_to topic_path(@topic)
  end

  protected

  def get_topic
    @topic = Topic.find( params[:topic_id] )
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end
