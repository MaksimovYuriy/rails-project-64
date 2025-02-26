class CommentsController < ApplicationController
  before_action :set_post, only: %i[ index new create ]

  def create
    debugger
    if @is_authorized

      @post_comment = @post.post_comments.build(post_comment_params)
      @post_comment.user = current_user
      @post_comment.save
    
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
