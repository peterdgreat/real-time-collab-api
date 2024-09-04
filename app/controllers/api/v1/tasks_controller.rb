class Api::V1::TasksController < ApplicationController
  def create
    task = Task.new(task_params)
    if task.save
      ActionCable.server.broadcast("document_#{task.document_id}", { type: 'new_task', task: task })
      render json: task, status: :created
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  def update
    task = Task.find(params[:id])
    if task.update(task_params)
      ActionCable.server.broadcast("document_#{task.document_id}", { type: 'update_task', task: task })
      render json: task
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:user_id, :document_id, :title, :description, :status)
  end
end
