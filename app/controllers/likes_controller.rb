class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @post_like = PostLike.new(user: current_user, post: @post)
    if @post_like.save
      redirect_to post_path(@post)
    else
      redirect_to root_path
    end
  end

  def destroy
    @post_like = PostLike.find(params[:id])
    if !@post_like.nil?
      @post_like.destroy
      redirect_to post_path(@post)
    else
      redirect_to root_path
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
