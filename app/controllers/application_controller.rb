class ApplicationController < ActionController::API
  before_action :authenticate_user!
  respond_to :json
  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

  def render_json_response(resource)
    if resource.errors.empty?
      render json: resource
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
end
