# # load 'shared_functions.rb'
# require 'shared_functions'

class Users::RegistrationsController < Devise::RegistrationsController
  # respond_to :json
  # before_action :configure_permitted_parameters, if: :devise_controller?
  # include Shared
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
        msg = find_message(:signed_up)
        console_msg('success', msg)
        render json: { message: msg, resource: resource }, status: :created
      else
        expire_data_after_sign_in!
        msg = find_message(:"signed_up_but_#{resource.inactive_message}")
        console_msg('error', msg)
        render json: { message: :msg,
                       resource: resource.errors }, status: 400
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      # msg = I18n.translate('errors.messages.not_found')
      # varibale = resource.errors.dup
      # modify_msg_json(varibale)
      console_msg('error', 'Email is invalid or already taken')
      render json: { message: 'Email is invalid or already taken' }, status: 400
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
      console_msg('success', find_message(:updated))
      # render json: { message: I18n.translate('devise.registrations.updated'), resource: resource }, status: 400
      # render json: { message: @msg_json, resource: resource }
      render json: { message: find_message(:updated), resource: resource }
    else
      clean_up_passwords resource
      set_minimum_password_length
      # respond_with resource
      # render json: { message: I18n.translate('errors.messages.not_found'), resource: resource.errors }, status: 400
      console_msg('error', @msg_json)
      render json: { message: @msg_json, resource: resource.errors }, status: 400
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  # end

  private

  @msg_json = ''

  def modify_msg_json(msg)
    @msg_json = msg
  end

  def set_flash_message_for_update(resource, prev_unconfirmed_email)
    return unless is_flashing_format?

    flash_key = if update_needs_confirmation?(resource, prev_unconfirmed_email)
                  :update_needs_confirmation
                elsif sign_in_after_change_password?
                  :updated
                else
                  :updated_but_not_signed_in
                end

    modify_msg_json(flash_key)
    # set_flash_message :notice, flash_key
  end

  def retrieve_devise_msg_error
    resource.errors
  end
end
