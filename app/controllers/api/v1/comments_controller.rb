class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!
  include ErrorHandling

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      render json: @comment, status: :created
    else
      render_error(@comment)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:document_id, :content)
  end
end
