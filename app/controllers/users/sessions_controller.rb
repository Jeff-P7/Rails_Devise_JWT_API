class Users::SessionsController < Devise::SessionsController
  # respond_to :json

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?

    msg = find_message(:signed_in)
    console_msg('success', msg)
    render json: { message: msg, user: resource }
    # render json: { message: msg, resource: resource }
    # respond_with resource
    # respond_with resource, location: after_sign_in_path_for(resource)
  end

  private

  def respond_with(resource, _opts = {})
    render_json_response(resource)

    # if resource.errors.empty?
    #   render json: resource, { token: resource.token }
    #   # render json: resource, {message: I18n.t("devise.sessions.signed_in")}
    # else
    #   render json: resource.errors, status: 400
    # end
  end

  def respond_to_on_destroy
    head :no_content
  end
end
