# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @posts = Post.order(created_at: :desc).includes(:creator)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_like = PostLike.find_by(user: current_user, post: @post)
    @nested_comments = @post.comments.includes(:user).arrange(order: :created_at)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = I18n.t('post.created')
      redirect_to post_path(@post)
    else
      flash[:warning] = I18n.t('post.create_error')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
