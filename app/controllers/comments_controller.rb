# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[create]

  def create
    @post_comment = @post.comments.build(post_comment_params)
    @post_comment.user = current_user

    if @post_comment.save
      flash[:success] = I18n.t('comment.created')
    else
      flash[:warning] = I18n.t('comment.empty')
    end
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def post_comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
