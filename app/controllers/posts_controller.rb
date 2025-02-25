class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    if @is_authorized
      @post = Post.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  private 

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end

end
