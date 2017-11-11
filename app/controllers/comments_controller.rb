class CommentsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]

  def new
    @meetup = Meetup.find(params[:meetup_id])
    @comment = Comment.new
  end

  def create
    @meetup = Meetup.find(params[:meetup_id])
    @comment = Comment.new(comment_params)
    @comment.meetup = @meetup
    @comment.user = current_user

    if @comment.save
      redirect_to meetup_path(@meetup)
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
  
end
