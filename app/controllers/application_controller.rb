class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json

  def current_user
    Rails.logger.info("Current user: #{super.inspect}")
    super
  end
end
