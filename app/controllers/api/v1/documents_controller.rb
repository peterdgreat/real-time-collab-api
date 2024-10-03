class Api::V1::DocumentsController < ApplicationController
  # before_action :authenticate_user!
  include ErrorHandling

  def index
    Rails.logger.info("Current User ID: #{current_user.id}")

    # Fetch documents based on the type parameter
    case params[:type]
    when 'owned'
      documents = Document.where(user_id: current_user.id).includes(:users).map do |doc|
        doc.as_json(include: { users: { only: [:id, :email] } }).merge(is_owned: true)
      end
    when 'shared'
      documents = Document.joins(:document_users).where(document_users: { user_id: current_user.id }).includes(:users).map do |doc|
        doc.as_json(include: { users: { only: [:id, :email] } }).merge(is_owned: false)
      end
    else
      # Fetch all documents (both owned and shared)
      owned_documents = Document.where(user_id: current_user.id).includes(:users).map do |doc|
        doc.as_json(include: { users: { only: [:id, :email] } }).merge(is_owned: true)
      end

      shared_documents = Document.joins(:document_users).where(document_users: { user_id: current_user.id }).includes(:users).map do |doc|
        doc.as_json(include: { users: { only: [:id, :email] } }).merge(is_owned: false)
      end

      documents = owned_documents + shared_documents
    end

    Rails.logger.info("Documents: #{documents.inspect}")
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
    Rails.logger.info("Current User ID: #{current_user.id}") # Log the current user ID
    if current_user.nil?
      Rails.logger.error("Current user is nil")
      render json: { error: "User must be logged in" }, status: :unauthorized
      return
    end

    # Explicitly set the user when creating the document
    @document = Document.new(document_params.merge(user: current_user))

    Rails.logger.info("Document User ID: #{@document.user_id}") # Log the document user ID
    if @document.save
      ActionCable.server.broadcast("document_#{@document.id}", { message: "Document created", document: @document })
      render json: @document, status: :created
    else
      render_error(@document)
    end
  end



  def get_draft
    document = current_user.documents.find_by(id: params[:id], draft: true)
    if document
      render json: document
    else
      render json: { message: 'No draft available' }, status: :not_found
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

  def share
    document = Document.find(params[:id])
    user = User.find_by(email: params[:email]) # Assuming you share by email

    if user && document.users.exclude?(user)
      document.users << user
      render json: { message: "Document shared successfully." }, status: :ok
    else
      render json: { error: "User not found or already has access." }, status: :unprocessable_entity
    end
  end

  def contributors
    document = Document.find_by(id: params[:id])

    if document
      contributors = document.users.pluck(:email)
      render json: { contributors: contributors }, status: :ok
    else
      render_not_found("Document")
    end
  end


  private

  def document_params
    params.require(:document).permit(:title, :content)
  end
end
