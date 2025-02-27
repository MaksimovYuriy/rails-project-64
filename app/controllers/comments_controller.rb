class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ create ]

  def create
    @post_comment = @post.post_comments.build(post_comment_params)
    @post_comment.user = current_user

    if @post_comment.save
      redirect_to post_path(@post) 
    else
      redirect_to new_user_session_path
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def post_comment_params
    params.require(:post_comment).permit(:body)
  end

end
