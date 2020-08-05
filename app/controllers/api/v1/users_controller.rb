class Api::V1::UsersController < ApplicationController
    def index
        users = User.all.order(created_at: :desc)
        render json: users
    end
end
