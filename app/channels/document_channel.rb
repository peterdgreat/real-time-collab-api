class DocumentChannel < ApplicationCable::Channel
  def subscribed
    # Stream from a specific document
    stream_from "document_#{params[:document_id]}"
     Rails.logger.info "Subscribed to document_#{params[:document_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    Rails.logger.info "Unsubscribed from document_#{params[:document_id]}"
  end

  def update_document(data)
    # Broadcast the updated document content to all subscribers
    ActionCable.server.broadcast("document_#{params[:document_id]}", data)
    Rails.logger.info "Updated document_#{params[:document_id]} with data: #{data}"
  end


end
