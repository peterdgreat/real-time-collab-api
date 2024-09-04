class DocumentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "document_#{params[:document_id]}"
  end

  def receive(data)
    ActionCable.server.broadcast("document_#{params[:document_id]}", data)
  end
end
