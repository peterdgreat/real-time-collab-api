# app/controllers/concerns/error_handling.rb
module ErrorHandling
  extend ActiveSupport::Concern

  private

  def render_error(resource, status = :unprocessable_entity)
    render json: { errors: resource.errors.full_messages }, status: status
  end

  def render_not_found(resource_name)
    render json: { error: "#{resource_name} not found" }, status: :not_found
  end

  def render_unauthorized(message = "Unauthorized access")
    render json: { error: message }, status: :unauthorized
  end

  def render_internal_server_error(message = "Internal server error")
    render json: { error: message }, status: :internal_server_error
  end
end
