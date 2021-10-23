# load 'shared_functions.rb'
require 'shared_functions'

class Users::RegistrationsController < Devise::RegistrationsController
  # respond_to :json
  # before_action :configure_permitted_parameters, if: :devise_controller?
  include Shared
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
        console_msg('success', 'User was successfully created')
        render json: { message: I18n.translate('devise.registrations.signed_up'), resource: resource }, status: :created
      else
        # set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        # respond_with resource, location: after_inactive_sign_up_path_for(resource)
        console_msg('error', resource.errors)
        render json: { message: I18n.translate('devise.registrations.signed_up_but_inactive'),
                       resource: resource.errors }, status: 400
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      msg = I18n.translate('errors.messages.not_found')
      console_msg('error', resource.errors)
      render json: { message: msg, resource: resource.errors }, status: 400
      # render json: { message: I18n.translate('errors.messages.not_found'), resource: resource.errors }, status: 400
    end
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

      # respond_with resource, location: after_update_path_for(resource)
      render json: { message: I18n.translate('devise.registrations.updated'), resource: resource }, status: 400
    else
      clean_up_passwords resource
      set_minimum_password_length
      # respond_with resource
      render json: { message: I18n.translate('errors.messages.not_found'), resource: resource.errors }, status: 400
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  # end
end
