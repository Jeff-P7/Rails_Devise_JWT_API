class Users::SessionsController < Devise::SessionsController
  # respond_to :json

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
