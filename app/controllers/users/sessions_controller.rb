class Users::SessionsController < Devise::SessionsController
  # respond_to :json

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?

    msg = find_message(:signed_in)
    console_msg('success', msg)
    # render json: { msg: msg, user: UserSerializer.new(resource).serializable_hash }
    # render json: { msg: msg, user: UserBlueprint.render(resource, view: :auth_user) }
    render json: UserBlueprint.render(current_user, view: :auth_user, root: :user, meta: { msg: msg })
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
    render json: { msg: find_message(:signed_out) }
  end
end
