class Api::UsersController < ApplicationController
  # before_action :find_user, only: %w[show]

  # GET /api/v1/users
  # def index
  #   @users = User.all
  #   render json: @users, status: 200
  #   console_msg('info', 'All Users Indexed')
  # end

  # GET /api/v1/users/:id
  # def show
  def self
    msg = 'User successfully fetched info'
    console_msg('success', msg)
    render json: { message: msg, user: current_user }

    # render_json_response(@user)

    # if @user.valid?
    #   render json: @user, status: 200
    #   console_msg('success', "User of id #{@user.id} found")
    # else
    #   render json: { failure: 'User not found' }, status: 404
    #   console_msg('error', @user.errors.full_messages[0])
    # end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def ping
    render json: { message: user_signed_in? ? 'Your signed in!' : 'Have fun with this roadblock' }
  end
end
