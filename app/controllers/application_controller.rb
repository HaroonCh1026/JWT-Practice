class ApplicationController < ActionController::API
  private

  def authenticate_user
    header = request.headers["Authorization"]

    if header.nil?
      render json: { error: "Token missing" }, status: :unauthorized
      return
    end

    token = header.split(" ").last

    begin
      decoded = JWT.decode(
        token,
        jwt_secret,
        true,
        algorithm: "HS256"
      )

      user_id = decoded[0]["user_id"]

      @current_user = User.find_by(id: user_id)

      if @current_user.nil?
        render json: { error: "User not found" }, status: :unauthorized
      end

    rescue JWT::ExpiredSignature
      render json: { error: "Token expired" }, status: :unauthorized

    rescue JWT::DecodeError
      render json: { error: "Invalid token" }, status: :unauthorized
    end
  end

  def jwt_secret
    Rails.application.secret_key_base
  end
end