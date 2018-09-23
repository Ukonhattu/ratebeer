class User < ApplicationRecord
    include RatingAverage

    has_secure_password

    validates :username, uniqueness: true,
                        length: {minimum: 3, maximum: 30}
    validates :password, length: {minimum: 4},
                        format: {with: /\d+/}, format: {with: /[A-Z]+/}
    has_many :ratings, dependent: :destroy
    has_many :beers, through: :ratings
    has_many :memberships
end
