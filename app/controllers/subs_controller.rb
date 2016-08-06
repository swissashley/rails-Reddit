class SubsController < ApplicationController

  before_action :is_moderator!, only: [:edit]

  def index
    render :index
  end

  def show
    @vote = Vote.new
    @sub = Sub.find_by(id: params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    sub_hash = sub_params
    sub_hash[:user_id] = current_user.id
    @sub = Sub.new(sub_hash)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
    render :edit
  end

  def update
    @sub = Sub.find_by(id: params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def is_moderator!
    @sub = Sub.find_by(id: params[:id])

    unless current_user.id == @sub.user_id
      flash.now[:errors] = ["Cannot edit sub, you are not the moderator."]
      render :show
    end

  end

end
