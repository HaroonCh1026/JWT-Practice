class AuthController < ApplicationController

  # POST /signup
  def signup
    user = User.new(user_params)

    if user.save
      render json: {
        message: "User created successfully",
        user: {
          id: user.id,
          name: user.name,
          email: user.email
        }
      }, status: :created
    else
      render json: {
        errors: user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end


  # POST /login
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])

      payload = {
        user_id: user.id,
        exp: 24.hours.from_now.to_i
      }

      token = JWT.encode(
        payload,
        jwt_secret,
        "HS256"
      )

      render json: {
        message: "Login successful",
        token: token
      }

    else
      render json: {
        error: "Invalid email or password"
      }, status: :unauthorized
    end
  end


  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def jwt_secret
    Rails.application.secret_key_base
  end
end