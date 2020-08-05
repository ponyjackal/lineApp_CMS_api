class Api::V1::AuthController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        admin = Admin.find_by(email: admin_login_params[:email])
        if admin && admin.authenticate(admin_login_params[:password])
            token = issue_token(admin)
            render json: {admin: AdminSerializer.new(admin), access_token: token}
        else
            render json: {error: 'That user could not be found'}, status: 401
        end
    end

    def show
        admin = Admin.find_by(id: admin_id)
        if logged_in?
            render json: admin
        else
            render json: {error: 'No user could be found'}, status: 401
        end
    end

    private
    def admin_login_params
        params.permit(:email, :password)
    end
end