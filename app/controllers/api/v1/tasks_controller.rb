class Api::V1::TasksController < ApplicationController
  before_action :authenticate_user!

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      render json: @task, status: :created
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:document_id, :title, :description, :status)
  end
end
