class UsersController < ApplicationController

   before_action :authenticate_user, only: [:profile]

  def profile
    render json: {
      id: @current_user.id,
      name: @current_user.name,
      email: @current_user.email
    }
  end
  def index
    render json: {
      message: "api v1 Users Index"}
  end
end
