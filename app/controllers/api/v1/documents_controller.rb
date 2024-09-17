class Api::V1::DocumentsController < ApplicationController
  before_action :authenticate_user!
  include ErrorHandling

  def index
    documents = current_user.documents.all
    render json: documents
  end

  def show
    document = Document.find_by(id: params[:id])
    if document
      render json: document
    else
      render_not_found("Document")
    end
  end

  def create
    @document = current_user.documents.new(document_params)
    if @document.save
      ActionCable.server.broadcast("document_#{@document.id}", { message: "Document created", document: @document })
      render json: @document, status: :created
    else
      render_error(@document)
    end
  end

  def update
    document = Document.find_by(id: params[:id])
    if document
      if document.update(document_params)
        ActionCable.server.broadcast("document_#{document.id}", { message: "Document updated", document: document })
        render json: document
      else
        render_error(document)
      end
    else
      render_not_found("Document")
    end
  end

  private

  def document_params
    params.require(:document).permit(:title, :content)
  end
end
