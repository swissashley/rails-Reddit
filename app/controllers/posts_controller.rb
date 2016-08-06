class PostsController < ApplicationController

  before_action :is_author, only: [:edit]

  def new
    render :new
  end

  def create
    post_hash = post_params
    post_hash[:user_id] = current_user.id
    post_hash[:sub_id] = 1
    @post = Post.new(post_hash)
    if @post.save

      @post.post_subs << PostSub.new

      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end


  end

  def show
    @post = Post.find_by(id: params[:id])
    @all_comments = @post.comments
    render :show
  end

  def edit
    @post = Post.find_by(id: params[:id])
    render :edit
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end

  end


  private
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def is_author
    @post = Post.find_by(id: params[:id])
    unless current_user.id == @post.author.id
      flash.now[:errors] = ["Cannot edit post, you are not the author."]
      render :show
    end
  end
end
