class Api::UsersController < ApplicationController
  # GET /api/v1/users
  def index
    @users = User.all
    render json: @users, status: 200
    console_msg('info', 'All Users Indexed')
  end

  def ping
    render json: { message: user_signed_in? ? 'Your signed in!' : 'Have fun with this roadblock' }
  end
end
