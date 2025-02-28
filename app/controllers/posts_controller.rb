class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[ new create ]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
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

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  private 

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end

end
