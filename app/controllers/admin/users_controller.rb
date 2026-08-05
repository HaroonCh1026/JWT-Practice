module Admin
  
  class UsersController < ApplicationController
        def index
                    render json: {
                        message: "Admin Users Index"
                    }
        end

        def show
            render json: {
                        message: "Admin Users Show" ,
                        user_id: params[:id]
                    }
        end
  end
  

end