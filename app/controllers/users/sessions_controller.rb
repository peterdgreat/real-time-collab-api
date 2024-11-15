module Users
  class SessionsController < Devise::SessionsController
    respond_to :json
    include ErrorHandling

    private

    def respond_with(resource, _opts = {})
      render json: {
        status: { code: 200, message: 'Logged in successfully.' },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes],
        token: current_token
      }, status: :ok
    end




  def current_token
    request.env['warden-jwt_auth.token']
  end

    def respond_to_on_destroy
      if current_user
        render json: {
          status: 200,
          message: "Logged out successfully."
        }, status: :ok
      else
        render_unauthorized("Couldn't find an active session.")
      end
    end
  end
end
