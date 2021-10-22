class Users::RegistrationsController < Devise::RegistrationsController
  # respond_to :json
  # before_action :configure_permitted_parameters, if: :devise_controller?

  # before_action do
  #   I18n.locale = :en # Or whatever logic you use to choose.
  # end

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        render json: { message: I18n.translate('devise.registrations.signed_up'), resource: resource }, status: 201
      else
        # set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        # respond_with resource, location: after_inactive_sign_up_path_for(resource)
        render json: { message: I18n.translate('devise.registrations.signed_up_but_inactive'),
                       resource: resource.errors }, status: 400
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: { message: I18n.translate('errors.messages.not_found'), resource: resource.errors }, status: 400
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  # end
end
