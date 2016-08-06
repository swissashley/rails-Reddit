class CommentsController < ApplicationController

  def new
    @post = Post.find_by(id: params[:post_id])
    render :new
  end

  def create
    # fail
    comment_hash = comment_params
    comment_hash[:user_id] = current_user.id

    if comment_hash[:post_id].nil?
      comment_hash[:post_id] = Comment.find_by(id: comment_hash[:parent_comment_id]).post.id
    end

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
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
