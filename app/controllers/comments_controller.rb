class CommentsController < ApplicationController

  def new
    @post = Post.find_by(id: params[:post_id])
    render :new
  end

  def create
    comment_hash = comment_params
    comment_hash[:user_id] = current_user.id
    @post =Post.find_by(id: comment_hash[:post_id])
    @comment = Comment.new(comment_hash)
    if @comment.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find_by(id: params[:id])
    render :show
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
