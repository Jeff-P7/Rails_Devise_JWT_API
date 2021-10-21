class ApplicationController < ActionController::API
  before_action :authenticate_user!
  respond_to :json
  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

  before_action :configure_permitted_parameters, if: :devise_controller?

  # before_action :configure_permitted_parameters, if: :devise_controller?
  # before_filter :configure_permitted_parameters, if: :devise_controller?

  def render_json_response(resource)
    if resource.errors.empty?
      render json: resource
      # render json: resource, {token: request.env['warden-jwt_auth.token']}
      # render json: resource, {message: I18n.t("devise.sessions.signed_in")}
    else
      render json: resource.errors, status: 400
    end
  end

  def record_not_unique(message)
    render json: {
      'errors': [
        {
          'status': '400',
          'title': message
        }
      ]
    }, status: 400
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  # # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  # end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password) }
  #   # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  # end
end
