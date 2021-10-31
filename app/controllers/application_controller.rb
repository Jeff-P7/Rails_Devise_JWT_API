# load 'shared_functions.rb'
require 'shared_functions'
class ApplicationController < ActionController::API
  before_action :authenticate_user!
  before_action :set_locale

  include Shared

  respond_to :json
  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

  before_action :configure_permitted_parameters, if: :devise_controller?

  # before_action :configure_permitted_parameters, if: :devise_controller?
  # before_filter :configure_permitted_parameters, if: :devise_controller?

  def render_json_response(resource)
    if resource.errors.empty?
      render json: { message: 'AYO your IN!', resouse: resource,
                     token: headers['Authorization'].present? ? headers['Authorization'].split(' ').last : { error: 'this hsit is fukced' } }
      # render json: { message: 'AYO your IN!', resouse: resource, token: request.authorization }
      # render json: resource, {token: request.env['warden-jwt_auth.token']}
      # render json: resource, {message: I18n.t("devise.sessions.signed_in")}
    else
      console_msg('error', resource.errors)
      render json: resource.errors, status: 400
    end
  end

  def set_locale
    # I18n.locale = request.headers["X-Lang"] || I18n.default_locale
    I18n.locale = :en
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

  def http_auth_header
    # if headers['Authorization'].present?
    #   return headers['Authorization'].split(' ').last
    # else
    #   errors.add(:token, 'Missing token')
    # end

    # nil

    return headers['Authorization'].split(' ').last if headers['Authorization'].present?
  end

  # def bearer_token
  #   pattern = /^Bearer /
  #   header  = request.env['Authorization'] # <= env
  #   header.gsub(pattern, '') if header && header.match(pattern)
  # end

  # # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  # end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password) }
  #   # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  # end

  # def i18n_message(default = nil)
  #   message = warden_message || default || :unauthenticated

  #   if message.is_a?(Symbol)
  #     options = {}
  #     options[:resource_name] = scope
  #     options[:scope] = "devise"
  #     options[:default] = [message]
  #     auth_keys = scope_class.authentication_keys
  #     keys = (auth_keys.respond_to?(:keys) ? auth_keys.keys : auth_keys).map { |key| scope_class.human_attribute_name(key) }
  #     options[:authentication_keys] = keys.join(I18n.translate(:"support.array.words_connector"))
  #     options = i18n_options(options)

  #     I18n.t(:"#{scope}.#{message}", **options)
  #   else
  #     message.to_s
  #   end
  # end
end
