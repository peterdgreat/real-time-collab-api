class Api::V1::CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      ActionCable.server.broadcast("document_#{comment.document_id}", { type: 'new_comment', comment: comment })
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :document_id, :content)
  end
end
