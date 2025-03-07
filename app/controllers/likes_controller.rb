# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @post_like = PostLike.new(user: current_user, post: @post)
    if @post_like.save
      flash[:success] = 'You liked this post!'
      redirect_to post_path(@post)
    else
      flash[:notice] = 'Hmmm.... Some error with likes...'
      redirect_to root_path
    end
  end

  def destroy
    @post_like = PostLike.find_by(id: params[:id])
    if @post_like.nil? || @post_like.user != current_user
      redirect_to root_path
    else
      @post_like.destroy
      redirect_to post_path(@post_like.post)
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
