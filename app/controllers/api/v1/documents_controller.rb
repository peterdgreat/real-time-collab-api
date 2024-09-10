class Api::V1::DocumentsController < ApplicationController
  before_action :authenticate_user!

  def index
    documents = Document.all
    render json: documents
  end

  def show
    document = Document.find(params[:id])
    render json: document
  end

  def create
    @document = current_user.documents.new(document_params)
    if @document.save
      render json: @document, status: :created
    else
      render json: { errors: @document.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    document = Document.find(params[:id])
    if document.update(document_params)
      ActionCable.server.broadcast("document_#{document.id}", { type: 'update', content: document.content })
      render json: document
    else
      render json: document.errors, status: :unprocessable_entity
    end
  end

  private

  def document_params
    params.require(:document).permit(:title, :content)
  end
end
