module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json
    include ErrorHandling

    def create
      build_resource(sign_up_params)

      if resource.save
        render json: {
          status: { code: 200, message: 'Signed up successfully.' },
          data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
        }, status: :created
      else
        handle_registration_errors(resource)
      end
    end

    private

    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def handle_registration_errors(resource)
      if resource.errors.details[:email].any? { |error| error[:error] == :taken }
        render json: { error: 'Email has already been taken.' }, status: :conflict
      else
        render_error(resource)
      end
    end
  end
end
