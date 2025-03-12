# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = set_post
    @post_like = PostLike.new(user: current_user, post: post)
    if @post_like.save
      flash[:success] = I18n.t('post.like')
      redirect_to post_path(post)
    else
      flash[:warning] = I18n.t('post.like_error')
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
    Post.find(params[:post_id])
  end
end
