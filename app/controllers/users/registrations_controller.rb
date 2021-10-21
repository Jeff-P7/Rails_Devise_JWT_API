class Users::RegistrationsController < Devise::RegistrationsController
  # respond_to :json
  # before_action :configure_permitted_parameters, if: :devise_controller?

  # POST /users
  # Specs No
  #   def create
  #     build_resource(sign_up_params)

  #     resource.save
  #     if resource.persisted?
  #       render json: { message: I18n.t('controllers.registrations.confirm') }
  #     else
  #       render json: resource.errors, status: 401
  #     end
  #   end

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        # set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        # respond_with resource, location: after_sign_up_path_for(resource)
        render json: resource, success: true
        # render json: resource, success: true, { message: i18n_message }
        # render json: {resource: resource, message: i18n_message }
      else
        # set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        # respond_with resource, location: after_inactive_sign_up_path_for(resource)
        render json: { resource: resource.errors }
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      #   respond_with resource
      render json: { resource: resource.errors, status: 400 }
      #   render json: resource.errors, status: 400
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end


end
