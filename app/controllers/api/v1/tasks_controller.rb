class Api::V1::TasksController < ApplicationController
  before_action :authenticate_user!
  include ErrorHandling

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      render json: @task, status: :created
    else
      render_error(@task)
    end
  end

  private

  def task_params
    params.require(:task).permit(:document_id, :title, :description, :status)
  end
end
