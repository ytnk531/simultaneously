class PostsController < ApplicationController
  before_action :authenticate_user!, only: :create

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new(time: Time.current.beginning_of_minute)
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      TwitterPostJob.set(wait_until: @post.time).perform_later(@post)
      flash[:notification] = "Done"
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
