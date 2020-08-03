class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true
    validates :store, presence: true
    validates :created_at, presence: true
end
