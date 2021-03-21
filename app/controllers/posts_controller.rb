class PostsController < ApplicationController
  before_action :authenticate_user!, only: :create

  def index
    @posts = Post.where(user: current_user, time: Time.current-10.minutes..)
                 .order(time: :asc)
  end

  def new
    @post = Post.new(time: Time.current.beginning_of_minute)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to posts_path
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      TwitterPostJob.set(wait_until: @post.time).perform_later(@post.id)
      flash[:notification] = "Successfully scheduled."
      redirect_to posts_path
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :time)
  end
end
