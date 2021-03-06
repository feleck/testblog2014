class CommentsController < ApplicationController
  expose(:post)
  expose(:comment)

  def create
    self.comment = post.comments.create(params[:comment])
    comment.post = post
    comment.user = current_user 
    
    if comment.save
      redirect_to post, notice: "Comment created!"
    else
      redirect_to post, flash: { error: "Can't add empty comment!" } 
    end
  end

  def mark_as_not_abusive
    comment.abusive = false
    redirect_to post if comment.save
  end

  def vote_up
    if current_user.voted? comment
      redirect_to post, flash: { error: "Can't vote again!" }
    else
      Vote.create(user_id: current_user.id, comment_id: comment.id, value: 1)
      redirect_to post, notice: "Vote addad!"
    end
  end

  def vote_down
    if current_user.voted? comment
      redirect_to post, flash: { error: "Can't vote again!" }
    else
      Vote.create(user: current_user, comment: comment, value: -1)     
      redirect_to post, notice: "Vote added!"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
