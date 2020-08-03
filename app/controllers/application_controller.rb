class ApplicationController < ActionController::API
    before_action :authorized

    def jwt_key
        Rails.application.credentials.jwt_key
    end

    def issue_token(admin)
        JWT.encode({admin_id: admin.id}, jwt_key, 'HS256')
    end

    def decode_token
        begin
            JWT.decode(token, jwt_key, true, {:algorithm => 'HS256'})
        rescue JWT::DecodeError
            [{error: 'Invalid Token'}]
        end
    end

    def authorized
        render json: {message: 'Please log in'}, status: :unauthorized unless logged_in?
    end

    def token
        request.headers['Authorization']
    end

    def admin_id
        decode_token.first['admin_id']
    end

    def current_admin
        @admin ||= Admin.find_by(id: admin_id)
    end

    def logged_in?
        !!current_admin
    end
end
